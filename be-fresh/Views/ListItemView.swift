//  ListItemView.swift
//  fresh
//

import SwiftUI

struct ListItemView: View {
    var name: String
    var date: String
    var showLine: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    // point
                    Circle()
                        .fill(Color.white)
                        .frame(width: 10.0, height: 10)
                    
                    // item
                    VStack(alignment:.leading, spacing: 0) {
                        Text(name)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Text(date)
                            .font(.system(size: 15))
                    }
                    .padding(.leading)
                }
                .foregroundColor(Color.white)
                
                Spacer()
                Image("ItemBtn")
            }
            .padding(10)
            
            if (showLine) {
                Image("Line")
            }
        }
    }
}

// preview
struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
                .shadow(radius: 5)
            VStack(alignment: .leading) {
                ListItemView(name: "NAME", date: "2023-01-03", showLine: true)
                
                ListItemView(name: "NAME", date: "2023-01-03", showLine: true)
                
                ListItemView(name: "NAME", date: "2023-01-03", showLine: true)
                Spacer()
            }
            .padding([.top, .leading, .trailing])
        }
    }
}