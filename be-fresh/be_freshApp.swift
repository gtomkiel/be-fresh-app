import SwiftUI

@main
struct be_freshApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var defaultModel = DefautlModel()
        
    init() {
        persistenceController.deleteoldProducts()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
