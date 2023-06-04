import SwiftUI

struct SettingsView: View {
    @State private var showStatus = true
    @State private var showStatus1 = true
    @State private var showStatus2 = true
    @State private var showStatus3 = true
    @State private var showStatus4 = true
    @State private var showStatus5 = true
    
    var body: some View {
        VStack {
            HStack() {
                Text("Settings")
                Spacer()
            }
            .font(.system(size: 48))
            .fontWeight(.heavy)
            .padding([.leading, .trailing])
            .padding(.vertical, 20)
            List {
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue :217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option", isOn: $showStatus)
                    }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 1", isOn: $showStatus1)
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
