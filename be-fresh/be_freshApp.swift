import SwiftUI

@main
struct be_freshApp: App {
    let persistenceController = PersistenceController.shared
    // MARK -- DONT DELETE
    @StateObject var defaultModel = DefautlModel()
    
    init() {
        persistenceController.deleteoldProducts()
    }

    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            // use nvstack to Route the page
            NavigationStack {
                if defaultModel.first == false {
//                    NextContentView()
                    FirstContentView()
                        .environmentObject(defaultModel)
                } else {
                    if (defaultModel.isLoggedIn) {
                        ContentView()
                            .environmentObject(defaultModel)
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    } else {
                        LoginView().environmentObject(defaultModel)
                            .navigationDestination(isPresented: $defaultModel.showRegister) {
                                SignUpView().environmentObject(defaultModel)
                            }
                    }
                }
            }
        }
    }
}

