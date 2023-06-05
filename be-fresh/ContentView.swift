import SwiftUI

struct ContentView: View {
    @EnvironmentObject var defaultModel: DefautlModel
    
    var body: some View {
        TabView {
            HomePage()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProductsView()
                .tabItem() {
                    Image(systemName: "refrigerator")
                    Text("Products")
                }
            RecipesView()
                .tabItem() {
                    Image(systemName: "frying.pan")
                    Text("Recipes")
                }
            Bookmarks()
                .tabItem() {
                    Image(systemName: "bookmark")
                    Text("Bookmarks")
                }
            SettingsView()
                .tabItem() {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .accentColor(Color.init("greenColor"))
        .environmentObject(defaultModel) // MARK -- DONT DELETE
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
