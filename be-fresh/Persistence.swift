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
    
    func savePrName(prod: Product, name: String){
        prod.productName = name
        print("aaaaaaaaa")
        print(name)
        do {
            try container.viewContext.save()
            print("savavavavavaavaved")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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

