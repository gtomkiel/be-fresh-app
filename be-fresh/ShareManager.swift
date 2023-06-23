import Foundation

@MainActor class shareApi: ObservableObject {
    func shareLink(pasteData: String, completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "https://pastebin.com/api/api_post.php") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let payload = "api_dev_key=jvNjogb8EQC7GerNW_RkcdRxl2d7ErqQ&api_option=paste&api_paste_code=\(pasteData)&api_paste_expire_date=10M"
        request.httpBody = payload.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(responseString, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func getData(sharedUrl: String, completion: @escaping (String?, Error?) -> Void) {
        guard let lastComponent = sharedUrl.components(separatedBy: "/").last,
              let url = URL(string: "https://pastebin.com/raw/\(lastComponent)")
        else {
            completion(nil, NSError(domain: "", code: -1, userInfo: ["Error": "Invalid URL"]))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
            } else {
                if let responseData = data {
                    if let responseBody = String(data: responseData, encoding: .utf8) {
                        completion(responseBody, nil)
                    } else {
                        let error = NSError(domain: "", code: -2, userInfo: ["Error": "Couldn't decode the response"])
                        completion(nil, error)
                    }
                } else {
                    let error = NSError(domain: "", code: -3, userInfo: ["Error": "No data received"])
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
