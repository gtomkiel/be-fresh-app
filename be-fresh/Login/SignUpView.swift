//
//  RegisterView.swift
//  coreData
//

import SwiftUI
import CoreData

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var username = ""
    @State private var password = ""
    @State private var checkPassword = ""
    @State private var firstName = ""
    @State private var secondName = ""
    
    @EnvironmentObject var loginData: DefautlModel
    
    @State private var errorTips = ""
    @State private var showErrorTips = false
    
    @State private var showPassword = false
    @State private var showComfirmPassword = false
    
    func registerUser(username: String, password: String, checkPassword: String, firstName: String, secondName: String) {
        do {
            if password != checkPassword {
                throw LoginError.PasswordWrongError("Please enter a same password!")
            } else {
                
                if !username.isValidatorEmail() {
                    throw LoginError.isNotValidateEmail("Email is not validate")
                }
                
                let persistenceController = PersistenceController.shared
                
                let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "email == %@", username)
                
                let users = try persistenceController.container.viewContext.fetch(fetchRequest)
                print(users.count)
                // check if user in coredata
                guard users.count == 0 else {
                    throw LoginError.UserExistsError("User already exists. please change another username!")
                }
                
                let newUser = UserEntity(context: persistenceController.container.viewContext)
                newUser.email = username
                newUser.password = password
                newUser.firstName = firstName
                newUser.secondName = secondName
                print(username, password)
                
                try? persistenceController.container.viewContext.save()
                loginData.showRegister = false
                print("User created successfully")
            }
        } catch {
            print("Error fetching users: \(error)")
            
            switch error {
            case LoginError.UserExistsError(let err):
                errorTips = err
            case LoginError.PasswordWrongError(let err):
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
            Text("Register")
                .font(.largeTitle)
                .bold()
                .padding()
            
            VStack {
                TextField("Email", text: $username)
                    .keyboardType(.emailAddress)
//                    .("email")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .autocapitalization(.none)
//    .autocapitalization(2)
                
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
                registerUser(username: self.username, password: self.password, checkPassword: self.checkPassword, firstName: self.firstName, secondName: self.secondName)
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
