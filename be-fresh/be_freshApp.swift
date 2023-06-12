import SwiftUI

@main
struct be_freshApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var defaultModel = DefautlModel()
        
    init() {
        persistenceController.deleteoldProducts()
        var responseString: String? = nil

        // Send the command
        let command = "startBarcode"
        Server.shared.sendCommandToServer(command: command) { string in
            // Process the received string here
            responseString = string
            print(responseString ?? "error ocured")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
