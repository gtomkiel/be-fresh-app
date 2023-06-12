import SwiftUI

struct RecipeList: View {
    @StateObject var api = ApiCall(prompt: "Give me 5 recipe names separated by comma based on those products [chicken, tomato sauce, pasta, cheese, mushrooms]", temperature: "0.7")
    
    @State private var isShowingSheet = false
    @State private var customMealText = ""
    
    @State private var launched = false
    @State private var recipeFull = false
    @State var recipeName = ""
    
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
                            NavigationLink(destination: RecipesView(recipeName: item)) {
                                Text(item)
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(Color.white)
                                    .padding(20)
                                    .background(
                                        Rectangle()
                                            .foregroundColor(Color("greenColor"))
                                            .cornerRadius(15)
                                            .shadow(radius: 5)
                                    )
                            }
                        }
                    }
                }
                
                Spacer()
                
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingSheet = true
                    }) {
                        Image(systemName: "bubble.right.circle.fill")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .clipShape(Circle())
                    .shadow(radius: 10)
                }
            }
            .padding([.leading, .trailing])
            .onAppear {
                if !launched {
                    api.fetchData()
                    launched.toggle()
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                NavigationView {
                VStack {
                    Text("Custom Meal")
                        .fontWeight(.heavy)
                        .font(.system(size: 36))
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                        VStack {
                            TextField("...", text: $customMealText)
                                .foregroundColor(.white)
                                .padding(45)
                                .background(Color("greenColor"))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                            
                            NavigationLink(destination: RecipesView(recipeName: customMealText)) {
                                Text("Submit")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color.white)
                                    .padding(20)
                                    .background(
                                        Rectangle()
                                            .foregroundColor(Color("greenColor"))
                                            .cornerRadius(15)
                                            .shadow(radius: 5)
                                    )
                            }
                        }
                        .padding()
                        .presentationDetents([.fraction(0.45)])
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct RecipeListView: View {
    var recipeName: String
    
    var body: some View {
        Text("Recipe Details: \(recipeName)")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}