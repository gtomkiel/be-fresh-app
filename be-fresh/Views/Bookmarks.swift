//
//  Bookmarks.swift
//  be-fresh
//
//  Created by Grzegorz Tomkiel on 31/05/2023.
//

import SwiftUI

struct Bookmarks: View {
    @State private var text: String = ""
    @State private var isShowingSheet = false

    var body: some View {
        VStack(spacing: 32) {
            ScrollView {
                VStack(spacing: 32) {
                    Text("Bookmarks")
                        .font(.custom("Inter", size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .frame(width: 317, height: 54)
                        .padding(.leading, -10.0)
                        .padding([.top, .trailing], 69)

                    Text("Recipe")
                        .font(.custom("Inter", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .frame(width: 307, height: 29)
                        .offset(x: -120, y: 0)

                    Rectangle()
                        .frame(width: 339, height: 104)
                        .foregroundColor(Color(red: 129/255, green: 182/255, blue: 88/255))
                        .cornerRadius(15)
                        .overlay(
                            TextField("Enter text", text: $text)
                                .frame(width: 307, height: 29)
                                .font(.custom("Inter", size: 18))
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                        )

                    Text("Recipe")
                        .font(.custom("Inter", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .frame(width: 307, height: 29)
                        .offset(x: -120, y: 0)

                    Rectangle()
                        .frame(width: 339, height: 104)
                        .foregroundColor(Color(red: 129/255, green: 182/255, blue: 88/255))
                        .cornerRadius(15)
                        .overlay(
                            TextField("Enter text", text: $text)
                                .frame(width: 307, height: 29)
                                .font(.custom("Inter", size: 18))
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                        )
                    
                    Text("Recipe")
                        .font(.custom("Inter", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .frame(width: 307, height: 29)
                        .offset(x: -120, y: 0)

                    Rectangle()
                        .frame(width: 339, height: 104)
                        .foregroundColor(Color(red: 129/255, green: 182/255, blue: 88/255))
                        .cornerRadius(15)
                        .overlay(
                            TextField("Enter text", text: $text)
                                .frame(width: 307, height: 29)
                                .font(.custom("Inter", size: 18))
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                        )

                    Text("Recipe")
                        .font(.custom("Inter", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .frame(width: 307, height: 29)
                        .offset(x: -120, y: 0)

                    Rectangle()
                        .frame(width: 339, height: 104)
                        .foregroundColor(Color(red: 129/255,    green: 182/255, blue: 88/255))
                        .cornerRadius(15)
                        .overlay(
                            TextField("Enter text", text: $text)
                                .frame(width: 307, height: 29)
                                .font(.custom("Inter", size: 18))
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                        )
                }
                .padding(.top, -50)
                .padding(.horizontal, 0)
            }
            Spacer()
            
            // Button
            /*HStack{
                Spacer()
                Button(action: {
                    self.isShowingSheet = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.black)
                }
                .padding()
                .clipShape(Circle())
                .shadow(radius: 10)
            }*/
        }
    }
}

struct Bookmarks_Previews: PreviewProvider {
    static var previews: some View {
        Bookmarks()
    }
}
