import Foundation

struct Welcome : Codable {
    let choices: [Choice]
}

struct Choice : Codable {
    let text: String
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
        guard let url = URL(string: "https://api.openai.com/v1/completions"),
            let payload = "{\"model\": \"text-davinci-003\",\"prompt\": \"\(prompt)\",\"max_tokens\": 1000,\"temperature\": \(temperature)}".data(using: .utf8) else
        {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Don't push api key to github btw
        request.addValue("Bearer API-KEY-GOES-HERE", forHTTPHeaderField: "Authorization")
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
                    for choice in message.choices {
                        self.response += choice.text
                        self.response = self.response.trimmingCharacters(in: .newlines)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.response = "Could not retrieve data..."
                }
                print("definetly proper error handling")
            }
        }.resume()
    }
}

