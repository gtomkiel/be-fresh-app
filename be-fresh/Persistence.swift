import CoreData
import EventKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        let requestBookmark: NSFetchRequest<BookMark> = BookMark.fetchRequest()
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "be_fresh")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func calendarRemove(product: Product) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { [weak eventStore] granted, _ in
            guard granted else {
                print("event: access denied")
                return
            }
            
            guard let eventStore = eventStore else { return }
            
            let match = eventStore.predicateForEvents(withStart: product.expirationDate!, end: product.expirationDate!, calendars: eventStore.calendars(for: .event))
            
            let event = eventStore.events(matching: match)
            
            do {
                try eventStore.remove(event[0], span: .thisEvent)
            } catch {
                print("event: error")
            }
        }
    }
    
    func deleteProduct(_ product: Product) {
        calendarRemove(product: product)
        container.viewContext.delete(product)

        do {
            try container.viewContext.save()
        } catch {
            // Handle the error appropriately
            print("Failed to delete product: \(error)")
        }
    }
    
    func savePrName(product: Product, name: String) {
        let context = PersistenceController.shared.container.viewContext
        context.perform {
            product.productName = name
                
            do {
                try context.save()
                print("New product name saved successfully.")
            } catch {
                print("Failed to save new product name: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteoldProducts() {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let products = try container.viewContext.fetch(request)
            for product in products {
                if let expDate = product.expirationDate {
                    if expDate < Date() {
                        container.viewContext.delete(product)
                    }
                }
            }
            try container.viewContext.save()
        } catch {
            // Handle the error appropriately
            print("Failed to fetch products: \(error)")
        }
    }
    
    func getAllProducts() -> String {
        var allProductsString = ""
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let products = try container.viewContext.fetch(request)
            for product in products {
                allProductsString += "\(String(describing: product.productName!)) "
            }
        } catch {
            // Handle the error appropriately
            print("Failed to fetch products: \(error)")
        }
        return allProductsString
    }
    
    func saveBookmark(bookmark: BookMark, text: String) {
        let context = PersistenceController.shared.container.viewContext
        context.perform {
            bookmark.bookmark = text
            do {
                try context.save()
                print("New product name saved successfully.")
            } catch {
                print("Failed to save new product name: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteBookmarks() {
        let request: NSFetchRequest<BookMark> = BookMark.fetchRequest()
        do {
            let bookmarks = try container.viewContext.fetch(request)
            for bookmark in bookmarks {
                container.viewContext.delete(bookmark)
            }
            try container.viewContext.save()
        } catch {
            // Handle the error appropriately
            print("Failed to delete bookmarks: \(error)")
        }
    }
}
