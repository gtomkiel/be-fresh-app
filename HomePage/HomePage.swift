//
//  HomePage.swift
//  playingui
//
//  Created by Богдан Закусило on 09.05.2023.
//
import SwiftUI
import CoreData

struct HomePage: View {
    @EnvironmentObject var loginData: LoginData
    var body: some View {
        NavigationView(){
            GeometryReader { geometry in
                ZStack {
                    Color("backgroundColor")
                    VStack {
                        HStack {
                            Text("Hello")
                                .fontWeight(.bold)
                                .font(.system(size: 48))
                            
                            if loginData.isLoggedIn == false {
                                Spacer()
                                Button("Login") {
                                    loginData.showLogin = true
                                }
                                .foregroundColor(.white)
                                .frame(width: 60, height: 50)
                                .background(Color("greenColor"))
                                .cornerRadius(10)
                            } else {
                                Text(loginData.user!.firstName!)
                                    .fontWeight(.bold)
                                    .font(.system(size: 32))
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 32)
                    

                        VStack {
                            Text("Upcoming expire dates")
                                .padding(.trailing, 74.0)
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                            Rectangle()
                                .foregroundColor(Color("greenColor"))
                                .frame(width: 339, height: 264)
                                .cornerRadius(15)
                                .overlay {
                                    Rectangle()
                                        .foregroundColor(Color("lightGreen"))
                                        .frame(width: 320, height: 50)
                                        .cornerRadius(15)
                                }
                        }
                        
                        VStack {
                            Text("Todays recommendation")
                                .fontWeight(.semibold)
                                .font(.system(size: 24))
                                .padding(.trailing, 70.0)
                            Rectangle()
                                .foregroundColor(Color("greenColor"))
                                .frame(width: 339, height: 264)
                                .cornerRadius(15)
                                .overlay {
                                    Rectangle()
                                        .foregroundColor(Color("darkGreen"))
                                        .frame(width: 320, height: 50)
                                        .cornerRadius(15)
                                }
                                .overlay{
                                    Image("addButton")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 59, height: 59)
                                        .position(x: 300, y: 250)
                                }
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
