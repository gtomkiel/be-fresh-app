import SwiftUI

struct RegistrationView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State var UserName = UserDefaults.standard.string(forKey: "UserName")
    @State var PassWord = UserDefaults.standard.string(forKey: "Password")
    
    var body: some View {
        VStack {
            Spacer()
            Text("Registration")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 20)
            
            Button(action: register) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
    
    func register() {
        // Perform registration logic here
        // You can access the entered username and password using the `username` and `password` variables
        // Validate the input, store user data, etc.
        
        // Example validation: check if passwords match
        if password == confirmPassword {
            // Registration successful
            print("Registration successful!")
        } else {
            // Passwords do not match
            print("Passwords do not match")
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
