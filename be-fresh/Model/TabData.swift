import Foundation
/*import SwiftUI
import Combine
import CoreData

class DefautlModel: ObservableObject {

    @Published var pageStatus: PageType = .main
    @Published var isLoggedIn = false
    @Published var showLogin = false
    @Published var showRegister = false
    
    //@Published var selectedTab : TabItem = .home
    
    @Published var first = UserDefaults.standard.bool(forKey: "FirstTime")
}

extension String {
    func isValidatorEmail() -> Bool {
        if self.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}

enum LoginError: Error {
    case UserNotExistsError(String), PasswordWrongError(String), UserExistsError(String), isNotValidateEmail(String)
}

enum PageType {
    case login, register, main
}

/*
enum TabItem : Hashable, Identifiable {
    case products
    case recipes
    case home
    case bookmarks
    case settings
    var id: TabItem { self }
}
*/
*/

