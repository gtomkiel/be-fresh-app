import SwiftUI

@main
struct be_freshApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var defaultModel = DefautlModel()
        
    init() {
        persistenceController.deleteoldProducts()
        let parser = ApiParser()
        parser.getName(barcode: 9181991172523) { title in
            if let title = title {
                // Use the title here
                 print("Title: \(title)")
            } else {
                // Handle the case where no title is available
                print("No title found")
            }
        }
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
