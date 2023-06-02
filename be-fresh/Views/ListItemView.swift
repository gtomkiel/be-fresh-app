//  ListItemView.swift
//  fresh
//

import SwiftUI

struct ListItemView: View {
    var name: String
    var date: String
    var showLine: Bool
    @State private var isEditing = false
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
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
                    Button(action: {
                            self.isEditing.toggle()
                    }) {
                        HStack {
                            Image(systemName: "minus.circle")
                            Text(isEditing ? "Done" : "Edit")
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
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
