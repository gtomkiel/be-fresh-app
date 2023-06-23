import CodeScanner
import CoreData
import CoreImage
import CoreImage.CIFilterBuiltins
import EventKit
import Foundation
import SwiftUI

struct ProductsView: View {
    let parser = ApiParser()
    let api = shareApi()
    @State private var productName = ""
    @State private var shareLink = ""
    @State private var expiryDate = Date()
    @State var rem = UserDefaults.standard.bool(forKey: "RemoveRename")
    @State private var perCont = PersistenceController.shared
    @State private var isEditing = false
    @State private var currentDate = Date()
    @Environment(\.managedObjectContext) var viewContext
    @State private var isShowingSheet = false
    @State private var isShowingCamera = false
    @State private var isShowingDateInput = false
    @State private var isProductsOverlay = false
    @State private var isShareOverlay = false
    @State private var isImportOverlay = false
    @State private var isExportOverlay = false
    @State private var isManually = false
    @State private var isBarcodeSheet = false
    @State private var isErrorSheet = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    @State private var isSwiped = false
    @GestureState private var dragOffset: CGSize = .zero
    @State private var remove = false
    @State private var productList = String()
    @State private var qrCodeImage: UIImage?

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
                                isProductsOverlay = true
                            }) {
                                Image(systemName: "ellipsis.circle.fill")
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
                .sheet(isPresented: $isProductsOverlay, onDismiss: {
                    self.isProductsOverlay = false
                }, content: {
                    VStack {
                        Text("Options")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)
                        Spacer()
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Add product") {
                                    isProductsOverlay = false
                                    isShowingSheet = true
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
                                Button("Share list") {
                                    isProductsOverlay = false
                                    isShareOverlay = true
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                    }
                    .padding()
                    .presentationDetents([.fraction(0.35)])
                })
                .sheet(isPresented: $isShareOverlay, onDismiss: {
                    self.isShareOverlay = false
                }, content: {
                    VStack {
                        Text("Share products")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))
                            .padding(.bottom, 20)
                        Spacer()
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                Button("Import products") {
                                    isShareOverlay = false
                                    isImportOverlay = true
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
                                Button("Share products") {
                                    isShareOverlay = false
                                    isExportOverlay = true

                                    api.shareLink(pasteData: PersistenceController.shared.getAllProductsCSV()) { response, error in
                                        if let error = error {
                                            print(error)
                                        } else if let response = response {
                                            self.qrCodeImage = generateQRCode(from: response)
                                        }
                                    }
                                }
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            }
                    }
                    .padding()
                    .presentationDetents([.fraction(0.35)])
                })
                .sheet(isPresented: $isImportOverlay, onDismiss: {
                    self.isImportOverlay = false
                }, content: {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "https://pastebin.com/cmuP5XaX", shouldVibrateOnSuccess: true, completion: handleQrScan)
                })
                .sheet(isPresented: $isExportOverlay, onDismiss: {
                    self.isExportOverlay = false
                    self.qrCodeImage = nil
                }, content: {
                    VStack {
                        Text("Scan the QR code")
                            .fontWeight(.heavy)
                            .font(.system(size: 36))

                        if qrCodeImage != nil {
                            Image(uiImage: qrCodeImage!)
                                .resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 200, height: 200)

                            Rectangle()
                                .foregroundColor(Color("greenColor"))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .overlay {
                                    Button("Done") {
                                        self.isShowingSheet = false
                                        self.isShowingCamera = false
                                        self.isShowingDateInput = false
                                        self.isProductsOverlay = false
                                        self.isShareOverlay = false
                                        self.isImportOverlay = false
                                        self.isExportOverlay = false
                                        self.isManually = false
                                        self.isBarcodeSheet = false
                                        self.isErrorSheet = false
                                    }
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                }
                        } else {
                            ProgressView()
                        }
                    }
                    .padding()
                    .presentationDetents([.fraction(0.5)])
                })
                .sheet(isPresented: $isShowingSheet, onDismiss: {
                    self.isShowingSheet = false
                }, content: {
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
                                    var responseString: String?

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
                })
                .sheet(isPresented: $isManually, onDismiss: {
                    self.isManually = false
                }, content: {
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
                })
                .sheet(isPresented: $isBarcodeSheet, onDismiss: {
                    self.isBarcodeSheet = false
                }, content: {
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
                })
                .sheet(isPresented: .constant(false), onDismiss: {}, content: { // change later to swap when barecode was found
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
                })
                .sheet(isPresented: $isErrorSheet, onDismiss: {
                    self.isErrorSheet = false
                }, content: {
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
                })
                .sheet(isPresented: $isShowingCamera, onDismiss: {
                    self.isShowingCamera = false
                }, content: {
                    CodeScannerView(codeTypes: [.codabar, .code39, .code39Mod43, .code93, .code128, .ean8, .ean13, .interleaved2of5, .itf14, .upce], simulatedData: "7427037876898", shouldVibrateOnSuccess: true, completion: handleScan)
                })
                .sheet(isPresented: $isShowingDateInput, onDismiss: {
                    self.isShowingDateInput = false
                }, content: {
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
                })
            }
        }
    }

    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "exclamationmark.triangle.fill") ?? UIImage()
    }

    func handleQrScan(result: Result<ScanResult, ScanError>) {
        isImportOverlay = false

        switch result {
        case .success(let result):
            api.getData(sharedUrl: result.string) { result, error in
                if let error = error {
                    print("Error occurred")
                } else if let resultString = result {
                    let products = resultString.split(separator: ",").map(String.init)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

                    for i in stride(from: 0, to: products.count, by: 2) {
                        if i + 1 < products.count {
                            let dateTimeOffset = products[i + 1].components(separatedBy: " ")

                            if dateTimeOffset.count >= 3 {
                                let dateString = "\(dateTimeOffset[0]) \(dateTimeOffset[1]) +0000"
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                                if let date = dateFormatter.date(from: dateString) {
                                    addItem(nameFromBarcode: products[i], expirationDate: date)
                                }
                            }
                        }
                    }
                }
            }

        case .failure:
            print("Scanning failed")
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
            // the code below is for the real life, for presentation i need to change it.
//            let daysToSubtract = UserDefaults.standard.integer(forKey: "ExpireDate")
//
//            let calendar = Calendar.current
//            var dateComponent = DateComponents()
//            dateComponent.day = -daysToSubtract
//
//            let expDate = newProduct.expirationDate
//            let newExpirationDate = calendar.date(byAdding: dateComponent, to: expDate!)
//            print("----------------------")
//            print(newExpirationDate)
            // code for presentation
            var currentDate = Date()

            let calendar = Calendar.current
            let oneHour: TimeInterval = 80

            if let newDate = calendar.date(byAdding: .second, value: Int(oneHour), to: currentDate) {
                currentDate = newDate
                print("hrfiqehrg")
                print(currentDate)
            }
            Notification().sendNotification(date: currentDate, type: "time", title: "Product expiration", body: "Product \(String(describing: newProduct.productName!)) is expiring today")
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
