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
            NavigationStack {
                if defaultModel.first == false {
                    FirstContentView()
                        .environmentObject(defaultModel)
                } else {
                    ContentView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            .ignoresSafeArea()
        }
    }
}
