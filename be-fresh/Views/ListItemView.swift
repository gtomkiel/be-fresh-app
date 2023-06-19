import SwiftUI

struct ListItemView: View {
    @State var name: String
    var date: String
    var showLine: Bool
    var prdct: Product
    var rem: Bool
    var modification: Bool
    
    @State private var isEditing = false
    @State private var nutrition = false
    @State private var editedName = ""

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    // point
                    Circle()
                        .fill(Color.white)
                        .frame(width: 10.0, height: 10)
                    
                    // item
                    VStack(alignment: .leading, spacing: 0) {
                        if isEditing {
                            TextField("Enter name", text: $editedName)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        } else {
                            Text(name)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        
                        Text(date)
                            .font(.system(size: 15))
                    }
                    .padding(.leading)
                    
                }
                .foregroundColor(Color.white)
                
                Spacer()
              
                if rem && modification == true{
                    Button(action: {
                        isEditing.toggle()
                        if isEditing {
                            editedName = name
                        } else {
                            name = editedName
                            PersistenceController.shared.savePrName(product: prdct, name: name)
                        }
                    }) {
                        HStack {
                            Image(systemName: isEditing ? "checkmark" : "pencil")
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        self.nutrition = true
                    }) {
                        HStack {
                            Image(systemName: "list.clipboard")
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        PersistenceController.shared.deleteProduct(prdct)
                    }) {
                        HStack {
                            Image(systemName: "minus.circle")
                        }
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(10)
            .sheet(isPresented: $nutrition) {
                NutritionView(productName: prdct.productName ?? "nothing")
            }
            .presentationDetents([.fraction(0.35)]) // does nothing for some reason
        }
    }
}
