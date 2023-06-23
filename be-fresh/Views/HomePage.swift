import CoreData
import SwiftUI

struct HomePage: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default
    )
    private var products: FetchedResults<Product>

    @State private var animate = false
    @State private var text = false
    @State var daysToAdd = UserDefaults.standard.integer(forKey: "ExpireDate")

    @StateObject var api: ApiCall
    var allProducts = PersistenceController.shared.getAllProducts()

    init(allProducts: String) {
        self.allProducts = allProducts
        self._api = StateObject(wrappedValue: ApiCall(
            prompt: "Give me 5 recipe names in a unordered list using dots based on those products \(allProducts) keep it short",
            temperature: "0.7"
        ))
    }

    var body: some View {
        NavigationView {
            GeometryReader { _ in
                ZStack {
                    VStack {
                        HStack {
                            Text("Welcome")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.heavy)
                                .font(.system(size: 48))
                        }
                        .padding(.vertical, 20)
                        .opacity(animate ? 1.0 : 0.0)

                        ScrollView {
                            VStack {
                                Text("Upcoming expiry dates")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                Rectangle()
                                    .foregroundColor(Color("greenColor"))
                                    .frame(height: 264)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .overlay(
                                        ScrollView {
                                            VStack(alignment: .leading) {
                                                ForEach(products) { product in
                                                    HStack {
                                                        let calendar = Calendar.current
                                                        let dateComponents = calendar.dateComponents([.year, .month, .day], from: product.expirationDate!)

                                                        let formattedDate = "\(dateComponents.year ?? 0)/\(String(format: "%02d", dateComponents.month ?? 0))/\(String(format: "%02d", dateComponents.day ?? 0))"
                                                        if calculateDate(daysToAdd: daysToAdd) >= product.expirationDate! {
                                                            ListItemView(name: product.productName ?? "error", date: String(describing: formattedDate), showLine: true, prdct: product, rem: UserDefaults.standard.bool(forKey: "RemoveRename"), modification: false)
                                                        }
                                                    }
                                                }
                                                Spacer()
                                            }
                                        }
                                    )
                            }
                            .opacity(animate ? 1.0 : 0.0)
                            .padding(.bottom, 20)

                            VStack {
                                Text("Today's recommendation")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Rectangle()
                                    .foregroundColor(Color("greenColor"))
                                    .frame(height: 264)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .overlay {
                                        if api.response.isEmpty {
                                            ProgressView()
                                        } else {
                                            VStack {
                                                Text(api.response)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .font(.system(size: 20, weight: .bold))
                                                    .foregroundColor(Color.white)
                                                    .lineSpacing(25)
                                                    .padding(15)
                                                Spacer()
                                            }
                                            .opacity(text ? 1.0 : 0.0)
                                            .onAppear {
                                                if !text {
                                                    withAnimation(Animation.spring().speed(0.8)) {
                                                        text.toggle()
                                                    }
                                                }
                                                daysToAdd = UserDefaults.standard.integer(forKey: "ExpireDate")
                                            }
                                        }
                                    }
                            }
                            .opacity(animate ? 1.0 : 0.0)
                            .padding(.bottom, 20)
                            Spacer()
                        }
                    }
                }
            }
            .padding([.leading, .trailing])
            .background(Color(red: 253, green: 255, blue: 252))
            .onAppear {
                if !animate {
                    withAnimation(Animation.spring().speed(0.8)) {
                        animate.toggle()
                    }
                }
            }
        }
        .onAppear {
            api.response = ""
            api.fetchData()
        }
    }
}

func calculateDate(daysToAdd: Int) -> Date {
    let currentDate = Date()

    let calendar = Calendar.current
    let updatedDate = calendar.date(byAdding: .day, value: daysToAdd, to: currentDate)

    if let updatedDate = updatedDate {
        return updatedDate
    }
    return Date()
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(allProducts: "")
    }
}
