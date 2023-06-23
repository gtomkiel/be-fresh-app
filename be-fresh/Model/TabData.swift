import Combine
import CoreData
import Foundation
import SwiftUI

class DefautlModel: ObservableObject {
    @Published var first = UserDefaults.standard.bool(forKey: "FirstTime")
}
