import CoreData
import Foundation
import SwiftUI

struct ProductsView: View {
    @State private var isManually = false
    @State private var isBarcodeSheet = false
    @State var rem = UserDefaults.standard.bool(forKey: "RemoveRename")
    @State private var perCont = PersistenceController.shared
    @State private var isEditing = false
    @State private var currentDate = Date()
    @State private var isErrorSheet = false
    @Environment(\.managedObjectContext) var viewContext
    @State private var isShowingSheet = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    @State private var isSwiped = false
    @GestureState private var dragOffset: CGSize = .zero

    var body: some View {
        NavigationView {
            GeometryReader { _ in
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

                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
                                .shadow(radius: 5)
                                .frame(height: 602)

                            VStack(alignment: .leading) {
                                ForEach(products) { product in
                                    HStack {
                                        ListItemView(name: product.productName ?? "error", date: String(describing: product.expirationDate!), showLine: true, prdct: product, modification: true)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
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
                    VStack {
                        Text("Add Product")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)
                        Spacer()
                        Spacer()
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Input manually") {
                                    isShowingSheet = false
                                    isManually = true
                                    isBarcodeSheet = false
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Scan barecode") {
                                    isShowingSheet = false
                                    isManually = false
                                    isBarcodeSheet = true
                                    print("barcode stuff is running")
                                    var responseString: String? = nil

                                    // Send the command
                                    let command = "startBarcode"
                                    Server.shared.sendCommandToServer(command: command) { string in
                                        // Process the received string here
                                    responseString = string
                                    print(responseString ?? "error ocured")
                                        if let responseString = responseString{
                                            if responseString != ""{
                                                addItem(nameFromBarcode: responseString)
                                                isShowingSheet = false
                                                isManually = false
                                                isBarcodeSheet = false
                                            }
                                            else{
                                                isShowingSheet = false
                                                isManually = false
                                                isBarcodeSheet = false
                                                isErrorSheet = true
                                            }
                                        }
                                    }
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Testing add") {
                                    addItem(nameFromBarcode:  "Test shit idk")
                                    isShowingSheet = false
                                    isManually = false
                                    isBarcodeSheet = false
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                    }
                    .padding()
                    .presentationDetents([.fraction(0.35)])
                }
                .sheet(isPresented: $isManually) {
                    VStack {
                        Text("Add Product")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)
                        Spacer()
                        Spacer()
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Text("Product name")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                            }
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Text("Expiry date")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                            }
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Testing add") {
                                    addItem(nameFromBarcode: "Test Name")
                                    isShowingSheet = false
                                    isManually = false
                                    isBarcodeSheet = false
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                    }
                    .padding()
                    .presentationDetents([.fraction(0.35)])
                }
                .sheet(isPresented: $isBarcodeSheet) {
                    VStack {
                        Text("barecode will be here instead")
                        Spacer()
                    }
                    .presentationDetents([.fraction(0.5)])
                }
                .sheet(isPresented: $isErrorSheet){
                    Text("No such product in the database")
                }
            }
        }
    }

    private func addItem(nameFromBarcode: String) {
        withAnimation {
            var currentDate = Date()

            let calendar = Calendar.current
            let oneHour: TimeInterval = 360000

            if let newDate = calendar.date(byAdding: .second, value: Int(oneHour), to: currentDate) {
                currentDate = newDate
                print(currentDate)
            }
            let newProduct = Product(context: viewContext)
            newProduct.productName = nameFromBarcode
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
