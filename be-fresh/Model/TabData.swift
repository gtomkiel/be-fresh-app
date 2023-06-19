import Foundation
import SwiftUI
import Combine
import CoreData

class DefautlModel: ObservableObject {
    
    @Published var first = UserDefaults.standard.bool(forKey: "FirstTime")
}
