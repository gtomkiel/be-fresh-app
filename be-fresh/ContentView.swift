import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePage(allProducts: PersistenceController.shared.getAllProducts())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProductsView()
                .tabItem {
                    Image(systemName: "refrigerator")
                    Text("Products")
                }
            RecipeList(allProducts: PersistenceController.shared.getAllProducts())
                .tabItem {
                    Image(systemName: "frying.pan")
                    Text("Recipes")
                }
            Bookmarks()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Bookmarks")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .accentColor(Color("greenColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
