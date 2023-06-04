import SwiftUI

struct SettingsView: View {
    @State private var showStatus = true
    @State private var showStatus1 = true
    @State private var showStatus2 = true
    @State private var showStatus3 = true
    @State private var showStatus4 = true
    @State private var showStatus5 = true
    
    @EnvironmentObject var defaultModel: DefautlModel
    
    var body: some View {
        VStack {
            ScrollView {
                HStack() {
                    Text("Settings")
                    Spacer()
                }
                .font(.system(size: 48))
                .fontWeight(.heavy)
                .padding(.vertical, 20)
                
                VStack(spacing: 15) {
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue :217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Toggle option", isOn: $showStatus)
                                .padding()
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Toggle option 1", isOn: $showStatus1)
                                .padding()
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Toggle option 2", isOn: $showStatus2)
                                .padding()
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Toggle option 3", isOn: $showStatus3)
                                .padding()
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Toggle option 4", isOn: $showStatus4)
                                .padding()
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Toggle option 5", isOn: $showStatus5)
                                .padding()
                        }
                }
                
                Rectangle()
                    .foregroundColor(Color(red: 217, green: 217, blue: 217))
                    .cornerRadius(15)
                    .padding()
                
                Spacer()
                
                Button {
//                    UserDefaults.standard.set(true, forKey: "FirstTime")
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    UserDefaults.standard.set("", forKey: "LoggedInUserEmail")
                    defaultModel.isLoggedIn = false
//                    defaultModel.first = false
                } label: {
                    Text("Logout")
                        .foregroundColor(Color.white)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding()
            }
        }
        .padding([.leading, .trailing])
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
