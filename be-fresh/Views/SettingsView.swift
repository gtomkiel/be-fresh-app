import SwiftUI

struct SettingsView: View {
    @State private var showStatus = UserDefaults.standard.bool(forKey: "RemoveRename")
    @State private var expireDate = UserDefaults.standard.integer(forKey: "ExpireDate")
    @State private var isEditing = false
    @State private var showStatus2 = true
    @State private var showStatus3 = true
    @State private var showStatus4 = true
    @State private var showStatus5 = true
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing])
                    .fontWeight(.heavy)
                    .font(.system(size: 48))
            }
            .padding(.vertical, 20)
            List {
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue :217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Rename Delete Products", isOn: $showStatus)
                    }.onChange(of: showStatus) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "RemoveRename")
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        if isEditing {
                            TextField("Enter date", text: Binding<String>(
                                get: { String(expireDate) },
                                set: { expireDate = Int($0) ?? 0 }
                            ))
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        } else {
                            Text(String(expireDate))
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        Button(action: {
                            isEditing.toggle()
                            if isEditing == true{
                                UserDefaults.standard.set(Int(expireDate), forKey: "ExpireDate")
                                print(UserDefaults.standard.integer(forKey: "ExpireDate"))
                            }
                        }) {
                            HStack {
                                Image(systemName: isEditing ? "checkmark" : "pencil")
                            }
                        }
                    }
                    .padding(.leading)
                }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 2", isOn: $showStatus2)
                    }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 3", isOn: $showStatus3)
                    }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 4", isOn: $showStatus4)
                    }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 5", isOn: $showStatus5)
                    }
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color(red: 253, green: 255, blue: 252))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
