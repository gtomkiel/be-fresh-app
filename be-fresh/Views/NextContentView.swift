//
//  NextContentView.swift
//  playingui
//
//  Created by Богдан Закусило on 09.05.2023.
//
import SwiftUI

struct NextContentView: View {
    @EnvironmentObject var model: DefautlModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 0.0){
                Spacer(minLength: 30)
                Image("image2")
                    .resizable()
                    .aspectRatio(contentMode:  .fit)
                    .padding(.bottom, 35.0)
                    .frame(width: 300.0, height: 300.0)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elitIn molestie lacus ac congue")
                Text("pellentesque Donec")
                Spacer(minLength: 30)
//                NavigationLink(destination: HomePage()) {
                    Text("Start")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.horizontal, 8)
                        .frame(width: 110, height: 35)
                        .foregroundColor(.white)
                        .background(Color("greenColor"))
                        .cornerRadius(15)
                        .onTapGesture {
                            withAnimation {
                                UserDefaults.standard.set(false, forKey: "FirstTime")
                                model.first = false
                                dismiss()
                            }
                        }
//                }
            }
            .padding()
        }
    }
}

struct NextContentView_Previews: PreviewProvider {
    static var previews: some View {
        NextContentView()
    }
}