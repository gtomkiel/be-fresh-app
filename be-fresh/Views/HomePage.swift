import SwiftUI
import CoreData

struct HomePage: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    //@EnvironmentObject var model: DefautlModel
    @StateObject var api = ApiCall(prompt: "Give me 5 recipe names in a unordered list using dots based on those products [chicken, tomato sauce, pasta, cheese, mushrooms] keep it short", temperature: "0")
    
    @State private var animate = false
    @State private var text = false
    @State private var launched = false
    
    var body: some View {
        NavigationView(){
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HStack {
                            Text("Hello user")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.heavy)
                                .font(.system(size: 48))
                        }
                        .padding(.vertical, 20)
                        .opacity(animate ? 1.0 : 0.0)
                        
                        //<<<<<<< HEAD
                        
                        VStack {
                            Text("Upcoming expire dates")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            Rectangle()
                                .foregroundColor(Color("greenColor"))
                                .frame(height: 264)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .overlay(
                                    VStack(alignment: .leading) {
                                        ForEach(products) { product in
                                            HStack{
                                                if calculateDate() <= product.expirationDate!{
                                                    ListItemView(name: product.productName ?? "error", date: String(describing: product.expirationDate!), showLine: true, prdct: product, modification: false)
                                                }
                                            }
                                        }
                                        Spacer()
                                    }
                                )
                        }
                        .opacity(animate ? 1.0 : 0.0)
                        .padding(.bottom, 20)
                        
                        
                        VStack {
                            Text("Todays recommendation")
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Rectangle()
                                .foregroundColor(Color("greenColor"))
                                .frame(height: 264)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .overlay{
                                    if (api.response.isEmpty) {
                                        ProgressView()
                                    } else {
                                        VStack {
                                            Text(api.response)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .italic()
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(Color.white)
                                                .lineSpacing(25)
                                                .padding(15)
                                            Spacer()
                                        }
                                        .opacity(text ? 1.0 : 0.0)
                                        .onAppear {
                                            if (!text){
                                                withAnimation(Animation.spring().speed(0.8)) {
                                                    text.toggle()
                                                }
                                            }
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
            .padding([.leading, .trailing])
            .background(Color(red: 253, green: 255, blue: 252))
            .onAppear {
                if (!animate){
                    withAnimation(Animation.spring().speed(0.8)) {
                        animate.toggle()
                    }
                }
            }
        }
        .onAppear() {
            if (!launched) {
                api.fetchData()
                launched.toggle()
            }
        }
    }
}

func calculateDate()->Date{
    let currentDate = Date()
    let calendar = Calendar.current
    
    var dateComponents = DateComponents()
    dateComponents.day = UserDefaults.standard.integer(forKey: "ExpireDate")
    
    if let futureDate = calendar.date(byAdding: dateComponents, to: currentDate) {
        return futureDate
    } else {
        return Date()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
