import Foundation

class ApiParser {
    private var apiKey: String = ""
    
    func getName(barcode: Int, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.barcodelookup.com/v3/products?barcode=\(barcode)&formatted=y&key=\(apiKey)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let products = json["products"] as? [[String: Any]],
                   let firstProduct = products.first,
                   let title = firstProduct["title"] as? String
                {
                    completion(title)
                } else {
                    print("No products found")
                    completion(nil)
                }
            } catch {
                print("JSON parsing error: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
