//
//  coreDataApp.swift
//  coreData
//
//  Created by Богдан Закусило on 15.05.2023.
//

import SwiftUI

@main
struct coreDataApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var firstTimeChecker = FirstTimeChecker()
    @StateObject private var dbController = DbController()
    @StateObject var loginData = LoginData()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
                
                TabView(selection: $loginData.selectedTab) {
                    ProductsView()
                        .tabItem {
                            VStack {
                                Text("products")
                                
                                if (loginData.selectedTab == TabItem.products) {
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
                                if (loginData.selectedTab == TabItem.recipes) {
                                    Image("recipes_actived")
                                } else {
                                    Image("recipes")
                                }
                            }
                        }.tag(TabItem.recipes)
                        .environmentObject(loginData)
                    
                    
                    
                    if FirstTimeChecker().getFirstTime(context: firstTimeChecker.container.viewContext) == false {
                        ContentView()
                            .environment(\.managedObjectContext, firstTimeChecker.container.viewContext)
                            .tabItem {
                                Label("Index", systemImage: "person.crop.circle")
                            }.tag(TabItem.home)
                    }
                    else{
                        HomePage()
                            .environment(\.managedObjectContext, dbController.container.viewContext)
                            .tabItem {
                                Label("Index", systemImage: "person.crop.circle")
                            }.tag(TabItem.home)
                            .environmentObject(loginData)
                    }
                    
                    Bookmarks()
                        .tabItem {
                            VStack {
                                Text("Bookmarks")
                                if (loginData.selectedTab == TabItem.bookmarks) {
                                    Image("bookmarks_actived")
                                } else {
                                    Image("bookmarks")
                                }
                            }
                        }
                        .tag(TabItem.bookmarks)
                    
                    SettingView()
                        .tabItem{
                            VStack {
                                Text("Settings")
                                if (loginData.selectedTab == TabItem.settings) {
                                    Image("settings_actived")
                                } else {
                                    Image("settings")
                                }
                            }
                        }
                        .tag(TabItem.settings)
                        .environmentObject(loginData)
                }
                .accentColor(Color("greenColor"))
                .tint(Color("greenColor"))
                .ignoresSafeArea()
                
                .navigationDestination(isPresented: $loginData.showLogin) {
                    LoginView().environmentObject(loginData)
                }
                
                
                .navigationDestination(isPresented: $loginData.showRegister) {
                    RegisterView().environmentObject(loginData)
                }
                
                // another View showing methods
//                .fullScreenCover(isPresented: $loginData.showLogin) {
//                    NavigationStack {
//                        LoginView().environmentObject(loginData)
//                            .toolbar {
//                                ToolbarItem(placement: .navigationBarLeading) {
//                                    Button {
//                                        loginData.showLogin.toggle()
//                                    } label: {
//                                        Text("Cancel")
//                                    }
//                                }
//                            }
//                    }
//                }
//                .sheet(isPresented: $loginData.showRegister) {
//                    NavigationStack {
//                        RegisterView().environmentObject(loginData)
//                            .toolbar {
//                                ToolbarItem(placement: .navigationBarLeading) {
//                                    Button {
//                                        loginData.showRegister.toggle()
//                                    } label: {
//                                        Text("Cancel")
//                                    }
//                                }
//                            }
//                    }
//                }
                
            }
            .navigationViewStyle(.stack)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
