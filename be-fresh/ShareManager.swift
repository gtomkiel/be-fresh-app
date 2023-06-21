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
}
