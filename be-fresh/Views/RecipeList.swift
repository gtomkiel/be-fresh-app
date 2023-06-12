import SwiftUI

struct RecipeList: View {
    @StateObject var api = ApiCall(prompt: "Give me 5 recipe names separated by comma based on those products [chicken, tomato sauce, pasta, cheese, mushrooms]", temperature: "0.7")

    @State private var text = false
    @State private var launched = false
    @State private var recipeFull: Bool = false
    @State var recipeName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Recipes")
                    Spacer()
                }
                .font(.system(size: 48))
                .fontWeight(.heavy)
                .padding(.vertical, 20)

                Text("Recipes based on your products")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                ScrollView {
                    if api.response.isEmpty {
                        Rectangle()
                            .foregroundColor(Color("greenColor"))
                            .frame(height: 150)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .overlay {
                                ProgressView()
                            }
                    } else {
                        let list = api.response.components(separatedBy: ",")
                        ForEach(list, id: \.self) { item in
                            NavigationLink {
                                RecipesView(recipeName: item)
                            } label: {
                                Text(item)
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(Color.white)
                                    .padding(20)
                                    .background {
                                        Rectangle()
                                            .foregroundColor(Color("greenColor"))
                                            .cornerRadius(15)
                                            .shadow(radius: 5)
                                    }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding([.leading, .trailing])
            .onAppear {
                if !launched {
                    api.fetchData()
                    launched.toggle()
                }
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}
