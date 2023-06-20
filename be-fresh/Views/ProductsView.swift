import CodeScanner
import CoreData
import EventKit
import Foundation
import SwiftUI

struct ProductsView: View {
    let parser = ApiParser()
    @State private var productName = ""
    @State private var expiryDate = Date()
    @State private var isManually = false
    @State private var isBarcodeSheet = false
    @State var rem = UserDefaults.standard.bool(forKey: "RemoveRename")
    @State private var perCont = PersistenceController.shared
    @State private var isEditing = false
    @State private var currentDate = Date()
    @State private var isErrorSheet = false
    @Environment(\.managedObjectContext) var viewContext
    @State private var isShowingSheet = false
    @State private var isShowingCamera = false
    @State private var isShowingDateInput = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    @State private var isSwiped = false
    @GestureState private var dragOffset: CGSize = .zero
    @State private var remove = false

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

                        ScrollView {
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
                                            let calendar = Calendar.current
                                            let dateComponents = calendar.dateComponents([.year, .month, .day], from: product.expirationDate!)

                                            let formattedDate = "\(dateComponents.year ?? 0)/\(String(format: "%02d", dateComponents.month ?? 0))/\(String(format: "%02d", dateComponents.day ?? 0))"
                                            ListItemView(name: product.productName ?? "error", date: String(describing: formattedDate), showLine: true, prdct: product, rem: remove, modification: true)
                                        }
                                        .onAppear {
                                            remove = UserDefaults.standard.bool(forKey: "RemoveRename")
                                        }
                                    }
                                    Spacer()
                                }
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
                                        if let responseString = responseString {
                                            if responseString != "" {
                                                addItem(nameFromBarcode: responseString, expirationDate: Date())
                                                isShowingSheet = false
                                                isManually = false
                                                isBarcodeSheet = false
                                            } else {
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
                                Button("Phone camera") {
                                    isShowingSheet = false
                                    isManually = false
                                    isBarcodeSheet = false
                                    isShowingCamera = true
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

                        VStack {
                            TextField("Product name", text: $productName)
                                .padding(.horizontal)
                                .padding(.top)
                            DatePicker("Expiry date", selection: $expiryDate, displayedComponents: .date)
                                .padding(.horizontal)
                                .padding(.bottom)
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .background(Color("greenColor"))
                        .cornerRadius(15)
                        .shadow(radius: 5)

                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Confirm") {
                                    addItem(nameFromBarcode: productName, expirationDate: expiryDate)
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
                        Text("Scan the barcode now")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)

                        Image(systemName: "barcode.viewfinder")
                            .resizable()
                            .frame(width: 128, height: 128)
                            .foregroundColor(.black)
                    }
                    .presentationDetents([.fraction(0.35)])
                }
                .sheet(isPresented: .constant(false)) { // change later to swap when barecode was found
                    VStack {
                        Text("Add expiry date")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)

                        DatePicker("Expiry date", selection: $expiryDate, displayedComponents: .date)
                            .padding(.horizontal)
                            .padding(.bottom)
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .background(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)

                        Spacer()

                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Confirm") {
                                    addItem(nameFromBarcode: productName, expirationDate: Date())
                                    isShowingSheet = false
                                    isManually = false
                                    isBarcodeSheet = false
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                    }
                    .presentationDetents([.fraction(0.35)])
                }
                .sheet(isPresented: $isErrorSheet) {
                    VStack {
                        Text("Product not found!")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)

                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .frame(width: 128, height: 128)
                            .foregroundColor(.black)
                    }
                    .presentationDetents([.fraction(0.35)])
                }
                .sheet(isPresented: $isShowingCamera) {
                    CodeScannerView(codeTypes: [.codabar, .code39, .code39Mod43, .code93, .code128, .ean8, .ean13, .interleaved2of5, .itf14, .upce], simulatedData: "7427037876898", shouldVibrateOnSuccess: true, completion: handleScan)
                }
                .sheet(isPresented: $isShowingDateInput) {
                    VStack {
                        Text("Add Expiry date")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)

                        VStack {
                            Text("Expiry date")
                                .padding([.top, .leading, .trailing])

                            DatePicker("", selection: $expiryDate, displayedComponents: .date)
                                .labelsHidden()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding([.top, .leading, .trailing])
                                .accentColor(.white)
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .background(Color("greenColor"))
                        .cornerRadius(15)
                        .shadow(radius: 5)

                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Confirm") {
                                    addItem(nameFromBarcode: productName, expirationDate: expiryDate)
                                    isShowingSheet = false
                                    isManually = false
                                    isBarcodeSheet = false
                                    isShowingDateInput = false
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                    }
                    .padding()
                    .presentationDetents([.fraction(0.35)])
                }
            }
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingCamera = false

        switch result {
        case .success(let result):
            let scannedCode = result.string
            print(Int(scannedCode) ?? 0)
            parser.getName(barcode: Int(scannedCode) ?? 0) { title in
                if let title = title {
                    isShowingDateInput = true
                    self.productName = title
                } else {
                    print("No title found")
                }
            }

        case .failure:
            print("Scanning failed")
        }
    }

    private func calendarAdd(product: Product) {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { [weak eventStore] granted, _ in
            guard granted else {
                print("event: access denied")
                return
            }

            guard let eventStore = eventStore else { return }

            let event = EKEvent(eventStore: eventStore)
            event.title = product.productName! + " expires!"
            event.startDate = product.expirationDate
            event.endDate = product.expirationDate
            event.isAllDay = true
            event.calendar = eventStore.defaultCalendarForNewEvents

            do {
                try eventStore.save(event, span: .thisEvent)
                print("event: success")
            } catch {
                print("event: error")
            }
        }
    }

    private func addItem(nameFromBarcode: String, expirationDate: Date) {
        withAnimation {
            let newProduct = Product(context: viewContext)
            newProduct.productName = nameFromBarcode
            newProduct.expirationDate = expirationDate
            Notification().sendNotification(date: expirationDate, type: "time", title: "Product expiration", body: "Product \(String(describing: newProduct.productName!)) is expiring today")
            print("\(String(describing: newProduct.productName))")
            do {
                try viewContext.save()
                calendarAdd(product: newProduct)
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func addItemByName(date: Date, name: String) {
        withAnimation {
            var currentDate = Date()

            let calendar = Calendar.current
            let oneHour: TimeInterval = 360000

            if let newDate = calendar.date(byAdding: .second, value: Int(oneHour), to: currentDate) {
                currentDate = newDate
                print(currentDate)
            }
            let newProduct = Product(context: viewContext)
            newProduct.productName = name
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
