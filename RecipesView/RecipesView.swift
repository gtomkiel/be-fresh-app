//
//  RecipesView.swift
//  coreData
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var loginData: LoginData
    
    var body: some View {
        if loginData.isLoggedIn {
            VStack {
                HStack {
                    Text("Recipes")
                    Spacer()
                }
                VStack {
                    Rectangle()
                        .foregroundColor(Color("lightGreen"))
                        .cornerRadius(15)
                        .padding()
                }
            }
            .font(.system(size: 45))
            .fontWeight(.heavy)
            .padding()
        } else {
            Button {
//                    self.showLogin = true
                loginData.showLogin = true
            } label: {
                Text("Login")
            }
            .onAppear {
                loginData.showLogin = true
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
