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
                    Spacer()
                    Button(action: {
                        self.nutrition = true
                    }) {
                        HStack {
                            Image(systemName: "list.bullet.circle")
                        }
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    }
                }
                .foregroundColor(Color.white)
                
                Spacer()
              
                if rem && modification == true {
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
                            Image(systemName: isEditing ? "checkmark.circle" : "pencil.circle")
                        }
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        PersistenceController.shared.deleteProduct(prdct)
                    }) {
                        HStack {
                            Image(systemName: "trash.circle")
                        }
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    }
                }
            }
            .padding(10)
            
            .sheet(isPresented: $nutrition) {
                NutritionView(productName: prdct.productName ?? "nothing")
            }
        }
    }
}
