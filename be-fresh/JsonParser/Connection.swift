import Foundation

class Server{
    
    static let shared = Server()
    
    func sendCommandToServer(command: String, completion: @escaping (String?) -> Void) {
        
        let serverURL = URL(string: "http://192.168.198.217:852")!
        
        let serverURLWithCommand = serverURL.appendingPathComponent(command)
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: serverURLWithCommand) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        let responseString = String(data: data, encoding: .utf8)
                        completion(responseString)
                    } else {
                        print("No data received")
                        completion(nil)
                    }
                } else {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    completion(nil)
                }
            } else {
                print("Invalid response")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func connectToServer(){
        
    }
}
