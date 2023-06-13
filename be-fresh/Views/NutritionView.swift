import SwiftUI

struct NutritionView: View {
    @StateObject private var api: ApiCall
    @State private var text = false
    @State private var launched = false

    let productName: String

    init(productName: String) {
        self.productName = productName
        self._api = StateObject(wrappedValue: ApiCall(
            prompt: "Give me nutrition value for \(productName)",
            temperature: "0.7"
        ))
    }

    var body: some View {
        VStack {
            HStack {
                Text("Nutrition value")
                Spacer()
            }
            .font(.system(size: 48))
            .fontWeight(.heavy)
            .padding(.bottom, 10)
            ScrollView {
                if api.response.isEmpty {
                    Spacer()
                    ProgressView()
                } else {
                    Text(api.response)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(
                            Rectangle()
                                .foregroundColor(Color("greenColor"))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        )
                        .opacity(text ? 1.0 : 0.0)
                        .onAppear {
                            if !text {
                                withAnimation(Animation.spring().speed(0.8)) {
                                    text.toggle()
                                }
                            }
                        }
                }
            }
        }
        .padding()
        .onAppear {
            if !launched {
                api.fetchData()
                launched.toggle()
            }
        }
    }
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView(productName: "test")
    }
}
