import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var checkPassword = ""
    @State private var firstName = ""
    @State private var secondName = ""
    
    @State private var errorTips = ""
    @State private var showErrorTips = false
    
    @State private var showPassword = false
    @State private var showComfirmPassword = false
    var body: some View {
        Text("Register")
            .font(.largeTitle)
            .bold()
            .padding()
        
        VStack {
            TextField("Email", text: $username)
                .keyboardType(.emailAddress)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .autocapitalization(.none)
            
            HStack {
                TextField("FirstName", text: $firstName)
                    .padding()
                    .frame(width: 145, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                
                TextField("SecondName", text: $secondName)
                    .padding()
                    .frame(width: 145, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .autocapitalization(.none)
            }
            
        }
        .padding(.horizontal, 10)

        HStack {
           Group {
               if showPassword { // when this changes, you show either TextField or SecureField
                   TextField("Password", text: $password)
                       .padding()
                       .frame(width: 260, height: 50)
                       .background(Color.black.opacity(0.05))
                       .cornerRadius(10)
                       .autocapitalization(.none)
               } else {
                   SecureField("Password", text: $password)
                      .padding()
                      .frame(width: 260, height: 50)
                      .background(Color.black.opacity(0.05))
                      .cornerRadius(10)
                      .autocapitalization(.none)
               }
           }
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundColor(.red) // how to change image based in a State variable
                    .frame(width: 30)
            }
        }
        .padding([.horizontal, .top], 10)
   
        HStack {
           Group {
               if showComfirmPassword { // when this changes, you show either TextField or SecureField
                   TextField("Comfirm", text: $checkPassword)
                       .padding()
                       .frame(width: 260, height: 50)
                       .background(Color.black.opacity(0.05))
                       .cornerRadius(10)
                       .autocapitalization(.none)
               } else {
                   SecureField("Comfirm", text: $checkPassword)
                      .padding()
                      .frame(width: 260, height: 50)
                      .background(Color.black.opacity(0.05))
                      .cornerRadius(10)
                      .autocapitalization(.none)
               }
           }
            Button {
                showComfirmPassword.toggle()
            } label: {
                Image(systemName: showComfirmPassword ? "eye.slash" : "eye")
                    .foregroundColor(.red) // how to change image based in a State variable
                    .frame(width: 30)
            }
        }
        .padding()
        
        
        Button("Register") {
            // Authenticate user
        }
        .foregroundColor(.white)
        .frame(width: 300, height: 50)
        .background(Color.blue)
        .cornerRadius(10)
        
        HStack{
            Button {
                
            } label: {
                Text("Back to login")
            }
            Spacer()
        }
        .frame(width: 300)
        .padding(.leading)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
