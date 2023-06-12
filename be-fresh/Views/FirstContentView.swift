//
//  ContentView.swift
//  playingui
//
//  Created by Богдан Закусило on 26.04.2023.
//
import SwiftUI

struct FirstContentView: View {
    @EnvironmentObject var model: DefautlModel
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea()
                VStack(spacing: 0.0){
                    Spacer(minLength: 30)
                    Image("image")
                        .resizable()
                        .aspectRatio(contentMode:  .fit)
                        .padding(.bottom, 35.0)
                        .frame(width: 300.0, height: 300.0)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elitIn molestie lacus ac congue")
                    Text("pellentesque Donec")
                    Spacer(minLength: 30)
                    NavigationLink(destination: NextContentView().environmentObject(model)) {
                        Text("Next")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.horizontal, 8)
                            .frame(width: 110, height: 35)
                            .foregroundColor(.white)
                            .background(Color("greenColor"))
                            .cornerRadius(15)
                    }
                }
                .padding()
            }
        }
    }
}

struct FirstContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstContentView()
    }
}
