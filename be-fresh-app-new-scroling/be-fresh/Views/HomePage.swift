//
//  HomePage.swift
//  playingui
//
//  Created by Богдан Закусило on 09.05.2023.
//
import SwiftUI
import CoreData

struct HomePage: View {
    @EnvironmentObject var model: DefautlModel
    
    var body: some View {
        NavigationView(){
            GeometryReader { geometry in
                ZStack {
                    ScrollView {
                        Color("backgroundColor")
                        VStack {
                            HStack {
                                Text("Hello user")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.heavy)
                                    .font(.system(size: 48))
                            }
                            .padding(.vertical, 20)
                            
                            
                            VStack {
                                Text("Upcoming expire dates")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                Rectangle()
                                    .foregroundColor(Color("greenColor"))
                                    .frame(height: 264)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }
                            .padding(.bottom, 20)
                            
                            VStack {
                                Text("Todays recommendation")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 24))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Rectangle()
                                    .foregroundColor(Color("greenColor"))
                                    .frame(height: 204)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .overlay{
                                        Image("addButton")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 59)
                                            .position(x: 300, y: 250)
                                    }
                            }
                            .padding(.bottom, 20)
                            Spacer()
                        }
                    }
                }
                .padding([.leading, .trailing])
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
