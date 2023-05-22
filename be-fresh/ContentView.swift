import SwiftUI

struct ContentView: View {
    @State private var showStatus = true
    @State private var showStatus1 = true
    @State private var showStatus2 = true
    @State private var showStatus3 = true
    @State private var showStatus4 = true
    @State private var showStatus5 = true
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Settings")
                Spacer()
            }
            .font(.system(size: 45))
            .fontWeight(.heavy)
            .padding()
            
            VStack(spacing: 15) {
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color(red: 217, green: 217, blue :217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option", isOn: $showStatus)
                            .padding()
                    }
                    .padding([.leading, .trailing])
                
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 1", isOn: $showStatus1)
                            .padding()
                    }
                    .padding([.leading, .trailing])
                
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 2", isOn: $showStatus2)
                            .padding()
                    }
                    .padding([.leading, .trailing])
                
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 3", isOn: $showStatus3)
                            .padding()
                    }
                    .padding([.leading, .trailing])
                
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 4", isOn: $showStatus4)
                            .padding()
                    }
                    .padding([.leading, .trailing])
                
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .overlay {
                        Toggle("Toggle option 5", isOn: $showStatus5)
                            .padding()
                    }
                    .padding([.leading, .trailing])
            }
            
            Rectangle()
                .foregroundColor(Color(red: 217, green: 217, blue: 217))
                .cornerRadius(15)
                .padding()
            
            Spacer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
