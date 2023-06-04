//
//  LoginView.swift
//  coreData
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var errorTips = ""
    @State private var showErrorTips = false
    @State private var showPassword = false

    @EnvironmentObject var loginData: DefautlModel
    
    func isValidCredentials(username: String, password: String) {
        do {
            // String
            if !username.isValidatorEmail() {
                throw LoginError.isNotValidateEmail("Email is not validate")
            }
            
            // fetch user from coreData
            let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@ and password == %@", username, password)
            
            let persistenceController = PersistenceController.shared
            let users = try persistenceController.container.viewContext.fetch(fetchRequest)
            
            // check if user in coredata
            guard !users.isEmpty else {
                throw LoginError.UserNotExistsError("User not exists or wrong password")
            }
            
            // dispatch login
            DispatchQueue.main.async {
                loginData.isLoggedIn = true
                loginData.showLogin = false
                loginData.currentUser = users.first!
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(users.first!.email, forKey: "LoggedInUserEmail")
                dismiss()
            }
        } catch {
            print("Error fetching users: \(error)")
            
            switch error {
            case LoginError.UserNotExistsError(let err):
                errorTips = err
            case LoginError.isNotValidateEmail(let err):
                errorTips = err
            default:
                errorTips = "Login Failed. please try again later"
            }
            
            showErrorTips.toggle()
        }
    }
    
    var body: some View {
        VStack {
            Text("login")
                .font(.largeTitle)
                .bold()
                .padding()
            
            HStack {
                TextField("Username", text: $username)
                    .keyboardType(.emailAddress)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .autocapitalization(.none)
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
            .padding()
                
            Button("Login") {
                // Authenticate user
                DispatchQueue.main.async {
                    self.isValidCredentials(username: username, password: password)
                }
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            
            Button("Register") {
//                dismiss()
//                loginData.showLogin = false
                loginData.showRegister = true
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .alert(errorTips, isPresented: $showErrorTips) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
