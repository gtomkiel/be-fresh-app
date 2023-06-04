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
//     @State var first = UserDefaults.standard.bool(forKey: "FirstTime")
    
    init(){
        persistenceController.deleteoldProducts()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if defaultModel.first == false {
//                    NextContentView()
                    FirstContentView()
                        .environmentObject(defaultModel)
                } else {
                    if (defaultModel.isLoggedIn) {
                        ContentView()
                            .tabItem {
                                Label("Index", systemImage: "person.crop.circle")
                            }.tag(TabItem.home)
                            .environmentObject(defaultModel)
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    } else {
                        LoginView().environmentObject(defaultModel)
                            .navigationDestination(isPresented: $defaultModel.showRegister) {
                                SignUpView().environmentObject(defaultModel)
                            }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}
