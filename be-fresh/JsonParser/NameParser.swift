////
////  Parser.swift
////  be-fresh
////
////  Created by Богдан Закусило on 02.06.2023.
////
//
//import Foundation
//
//class NameParser{
//
//    func getNameFromJSON() -> String? {
//        // Provide the file path of the JSON file
//        let filePath = Bundle.main.path(forResource: "product", ofType: "json")
//
//        do {
//            // Retrieve the JSON data from the file
//            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath!))
//
//            // Parse the JSON data into a Swift object
//            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
//            
//            // Access the name field from the JSON object
//            if let name = json["name"] as? String {
//                return name
//            }
//        } catch {
//            print("Error: \(error)")
//        }
//
//        return nil
//    }
//}
//
//
//
//
//
//
//
//
