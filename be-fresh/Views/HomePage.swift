//
//  HomePage.swift
//  playingui
//
//  Created by Богдан Закусило on 09.05.2023.
//
import SwiftUI
import CoreData

struct HomePage: View {
    //@EnvironmentObject var model: DefautlModel
    @StateObject var api = ApiCall(prompt: "Give me 3 food recipe ideas in a list based on those products [chicken, tomato sauce, pasta, cheese, mushrooms] keep it short", temperature: "0.7")
    
    var body: some View {
        NavigationView(){
            GeometryReader { geometry in
                ZStack {
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
                                .frame(height: 264)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .overlay{
                                    if (api.response.isEmpty) {
                                        ProgressView()
                                    } else {
                                        Text(api.response)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.white)
                                            .padding(10)
                                    }
                                }
                        }
                        .padding(.bottom, 20)
                        Spacer()
                    }
                }
                .padding([.leading, .trailing])
                .background(Color(red: 253, green: 255, blue: 252))
            }
        }
        .onAppear() {
            //api.fetchData()
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
