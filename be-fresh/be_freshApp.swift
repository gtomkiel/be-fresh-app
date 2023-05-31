//
//  all_viewsApp.swift
//  all-views
//
//  Created by Богдан Закусило on 24.05.2023.
//
import SwiftUI
import Foundation

@main
struct be_freshApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var defaultModel = DefautlModel()
    // MARK -- move this line to defaultModel, so that we can change this param in other view
    // @State var first = UserDefaults.standard.bool(forKey: "FirstTime")
    
    init(){
        persistenceController.deleteoldProducts()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if defaultModel.first == false {
                    TabView(selection: $defaultModel.selectedTab) {
                        ProductsView()
                            .tabItem {
                                VStack {
                                    Text("products")
                                    
                                    if (defaultModel.selectedTab == TabItem.products) {
                                        Image("products_actived")
                                    } else {
                                        Image("products")
                                    }
                                }
                            }
                            .tag(TabItem.products)
                        
                        RecipesView()
                            .tabItem {
                                VStack {
                                    Text("Recipes")
                                    if (defaultModel.selectedTab == TabItem.recipes) {
                                        Image("recipes_actived")
                                    } else {
                                        Image("recipes")
                                    }
                                }
                            }.tag(TabItem.recipes)
                            .environmentObject(defaultModel)
                        
                        HomePage()
                            .tabItem {
                                Label("Index", systemImage: "person.crop.circle")
                            }.tag(TabItem.home)
                            .environmentObject(defaultModel)
                        
                        Bookmarks()
                            .tabItem {
                                VStack {
                                    Text("Bookmarks")
                                    if (defaultModel.selectedTab == TabItem.bookmarks) {
                                        Image("bookmarks_actived")
                                    } else {
                                        Image("bookmarks")
                                    }
                                }
                            }
                            .tag(TabItem.bookmarks)
                        
                        SettingsView()
                            .tabItem{
                                VStack {
                                    Text("Settings")
                                    if (defaultModel.selectedTab == TabItem.settings) {
                                        Image("settings_actived")
                                    } else {
                                        Image("settings")
                                    }
                                }
                            }
                            .tag(TabItem.settings)
                            .environmentObject(defaultModel)
                    }
                    .accentColor(Color("greenColor"))
                    .tint(Color("greenColor"))
                    .ignoresSafeArea()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    ContentView()
                        .tabItem {
                            Label("Index", systemImage: "person.crop.circle")
                        }.tag(TabItem.home)
                        .environmentObject(defaultModel)
                }
            }
        }
    }
}
