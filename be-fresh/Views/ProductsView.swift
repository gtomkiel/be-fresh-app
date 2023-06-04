import SwiftUI
import CoreData
import Foundation

struct ProductsView: View {
    @State private var isManually = false
    @State private var isBarcodeSheet = false
    @State var rem = UserDefaults.standard.bool(forKey: "RemoveRename")
    @State private var perCont = PersistenceController.shared
    @State private var isEditing = false
    @State private var currentDate = Date()
    @Environment(\.managedObjectContext) var viewContext
    @State private var isShowingSheet = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    @State private var isSwiped = false
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        NavigationView(){
            GeometryReader { geometry in
                ZStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Your products")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.heavy)
                                .font(.system(size: 48))
                        }
                        .padding(.vertical, 20)
                        
                        Text("List of items")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.semibold)
                            .font(.system(size: 24))
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
                                .shadow(radius: 5)
                            
                            VStack(alignment: .leading) {
                                ForEach(products) { product in
                                    HStack{
                                        ListItemView(name: product.productName ?? "error", date: String(describing: product.expirationDate!), showLine: true, prdct: product)
                                    }
                                }
                            Spacer()
                            }
                        }
                    }
                    
                    // button
                    VStack() {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                addItem()
                                isShowingSheet = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .clipShape(Circle())
                            .shadow(radius: 10)
                        }
                    }
                }
                .padding([.leading, .trailing])
                .sheet(isPresented: $isShowingSheet) {
                    VStack(alignment: .leading) {
                        Text("Add Product")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Button("Add manually"){
                            isShowingSheet = false
                            isManually = true
                        }
                        Spacer()
                        Button("Scan the barcode"){
                            isShowingSheet = false
                            isBarcodeSheet = true
                        }
                
                        
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
//                            .shadow(radius: 5)
//
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
//                            .shadow(radius: 5)
//                            .frame(height: 50)
                    }
                    .padding()
                    .presentationDetents([.fraction(0.5)])
                }
                .sheet(isPresented: $isManually){
                    Text("manually")
                }
                .sheet(isPresented: $isBarcodeSheet){
                    Text("barcode")
                }
            }
        }
    }
    private func addItem() {
        withAnimation {
            var currentDate = Date()

            let calendar = Calendar.current
            let oneHour: TimeInterval = 3600

            if let newDate = calendar.date(byAdding: .second, value: Int(oneHour), to: currentDate) {
                currentDate = newDate
                print(currentDate)
            }
            let newProduct = Product(context: viewContext)
            newProduct.productName = NameParser().getNameFromJSON()
            newProduct.expirationDate = currentDate
            Notification().sendNotification(date: currentDate, type: "time", title: "Product expiration", body: "Product \(String(describing: newProduct.productName!)) is expiring today")
            print("\(String(describing: newProduct.productName))")
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
