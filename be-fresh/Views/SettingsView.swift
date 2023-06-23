import SwiftUI

struct SettingsView: View {
    @State private var showStatus = UserDefaults.standard.bool(forKey: "RemoveRename")
    @State private var expireDate = UserDefaults.standard.integer(forKey: "ExpireDate")
    @State private var disableNotification = UserDefaults.standard.bool(forKey: "DisableNotification")
    @State private var enableAutoDeleteProducts = UserDefaults.standard.bool(forKey: "enableAutoDeleteProducts")
    @State private var isEditing = false
    @State private var pickerSheet = false
    
    var body: some View {
        NavigationStack {
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
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            NavigationLink {
                                AboutView()
                            } label: {
                                HStack {
                                    Text("About")
                                    Spacer()
                                }
                            }
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Additional product options", isOn: $showStatus)
                        }.onChange(of: showStatus) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "RemoveRename")
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Delete expired products", isOn: $enableAutoDeleteProducts)
                        }.onChange(of: enableAutoDeleteProducts) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "enableAutoDeleteProducts")
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Toggle("Notifaction", isOn: $disableNotification)
                        }.onChange(of: disableNotification) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "DisableNotification")
                        }
                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color(red: 217, green: 217, blue: 217))
                        .cornerRadius(15)
                        .overlay {
                            Button {
                                self.pickerSheet = true
                            } label: {
                                HStack {
                                    Text("Upcoming expiries")
                                    Spacer()
                                    Text("\(expireDate) \(expireDate == 1 ? "day" : "days")")
                                }
                            }
                        }
                }
                .scrollContentBackground(.hidden)
                .sheet(isPresented: $pickerSheet, onDismiss: {
                    self.pickerSheet = false
                }, content: {
                    VStack {
                        Picker("Days before expiration", selection: $expireDate) {
                            ForEach(0 ..< 15) { index in
                                Text("\(index) \(index == 1 ? "day" : "days")")
                                    .tag(index)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        
                        Button {
                            self.pickerSheet = false
                            UserDefaults.standard.set(Int(expireDate), forKey: "ExpireDate")
                        } label: {
                            Text("Done")
                        }
                    }
                    .presentationDetents([.fraction(0.35)])
                })
            }
        }
        .accentColor(Color("greenColor"))
        .listStyle(.plain)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
