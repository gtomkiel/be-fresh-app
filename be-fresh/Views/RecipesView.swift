import SwiftUI

struct RecipesView: View {
    @StateObject var api = ApiCall(prompt: "Give me formatted recipe based on those products [chicken, tomato sauce, pasta, cheese, mushrooms]", temperature: "0.7")
    
    @State private var text = false
    @State private var launched = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack() {
                    Text("Recipes")
                    Spacer()
                }
                .font(.system(size: 48))
                .fontWeight(.heavy)
                .padding(.vertical, 20)
                
                Text("Recipe Title")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                if(api.response.isEmpty) {
                    Rectangle()
                        .foregroundColor(Color("greenColor"))
                        .frame(height: 150)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .overlay{
                            if (api.response.isEmpty) {
                                ProgressView()
                            } else {
                                VStack {
                                    Text(api.response)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .fontWeight(.medium)
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.white)
                                        .padding(10)
                                    Spacer()
                                }
                            }
                        }
                } else {
                    GeometryReader { geo in
                        Text(api.response)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(
                                Rectangle()
                                    .frame(width: geo.size.width)
                                    .foregroundColor(Color("greenColor"))
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            )
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
                Spacer()
            }
            .padding([.leading, .trailing])
            .onAppear() {
                if (!launched) {
                    api.fetchData()
                    launched.toggle()
                }
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
