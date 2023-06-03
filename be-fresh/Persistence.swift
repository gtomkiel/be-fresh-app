import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "be_fresh")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func deleteProduct(_ product: Product) {
        container.viewContext.delete(product)

        do {
            try container.viewContext.save()
        } catch {
            // Handle the error appropriately
            print("Failed to delete product: \(error)")
        }
    }
    
    func savePrName(product: Product, name: String){
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
    
    func deleteoldProducts(){
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
}

