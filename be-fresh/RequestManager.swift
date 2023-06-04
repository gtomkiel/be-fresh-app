import Foundation

struct Welcome : Codable {
    let id, object: String?
    let created: Int?
    let model: String?
    let choices: [Choice]
}

struct Choice : Codable {
    let message: Message
    let finishReason: String?
    let index: Int?
}

struct Message : Codable {
    let role: String?
    var content: String
}

@MainActor class ApiCall: ObservableObject {
    
    @Published var response: String
    var prompt: String
    var temperature: String
    
    init(prompt: String, temperature: String) {
        self.prompt = prompt
        self.temperature = temperature
        self.response = String()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions"),
            let payload = "{\"model\": \"gpt-3.5-turbo\",\"messages\": [{\"role\": \"user\", \"content\": \"\(prompt)\"}],\"temperature\": 0.7}".data(using: .utf8) else
        {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Don't push api key to github btw
        request.addValue("Bearer API-KEY-HERE", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("Could not retrieve data...")
                                
                DispatchQueue.main.async {
                    self.response = "Could not retrieve data..."
                }
                
                return
            }
            
            do {
                let message = try JSONDecoder().decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    print(message)
                    for choice in message.choices {
                        self.response += choice.message.content + "\n"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.response = "Something broke"
                }
                print("definetly proper error handling")
            }
        }.resume()
    }
}
