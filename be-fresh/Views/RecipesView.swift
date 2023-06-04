import SwiftUI

struct RecipesView: View {
    @StateObject var api = ApiCall(prompt: "Give recipe based on those products [chicken, tomato sauce, pasta, cheese, mushrooms]", temperature: "0.7")
    
    var body: some View {
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
                            Text(api.response)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .padding(10)
                        }
                    }
            } else {
                Text(api.response)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding(10)
                    .background(
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    )
            }
            Spacer()
        }
        .padding([.leading, .trailing])
        .onAppear() {
            api.fetchData()
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
