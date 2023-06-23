import SwiftUI

@main
struct be_freshApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var defaultModel = DefautlModel()

    init() {
        if UserDefaults.standard.bool(forKey: "enableAutoDeleteProducts") {
            persistenceController.deleteoldProducts()
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if defaultModel.first == false {
                    InitialView()
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
