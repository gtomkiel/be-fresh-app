//
//  Products.swift
//  fresh
//  products list


import SwiftUI
import CoreData

struct ProductsView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State private var isShowingSheet = false
//    @State private var products = [Product]
    var body: some View {
            // basic layout
        NavigationView(){
            GeometryReader { geometry in
                ZStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Your")
                            Text("Products")
                        }
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                        .padding([.top, .bottom])
                        
                        Text("List of items")
                            .font(.title)
                            .fontWeight(.medium)
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
                                .shadow(radius: 5)
                            
                            VStack(alignment: .leading) {
                                // item list
                                ListItemView(name: "Product 1", date: "08/11", showLine: true)
                                
                                Spacer()
                            }
                            .padding([.top, .leading, .trailing])
                        }
                    }
                    .padding()
                    
                    // button
                    VStack() {
                        Spacer()
                        HStack {
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
                        }
                    }
                }
                // overlay
                .sheet(isPresented: $isShowingSheet) {
                    VStack(alignment: .leading) {
                        Text("Add Product")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
                            .shadow(radius: 5)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.506, green: 0.718, blue: 0.345))
                            .shadow(radius: 5)
                            .frame(height: 50)
                    }
                    .padding()
                    .presentationDetents([.fraction(0.5)])
                }
            }
        }
    }
}
struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
