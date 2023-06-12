import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProductsView()
                .tabItem {
                    Image(systemName: "refrigerator")
                    Text("Products")
                }
            RecipeList()
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
