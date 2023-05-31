import Foundation
import UserNotifications

class Notification {
    var permissionNotofication = UserDefaults.standard.bool(forKey: "Notification")
    func askPerm() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted")
                UserDefaults.standard.set(true, forKey: "Notification")
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String) {
        if permissionNotofication == true{
            var trigger: UNNotificationTrigger?
            if type == "date" {
                let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            }
            else if type == "time"{
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            }
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.title = body
            content.sound = UNNotificationSound.default
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        else{
            askPerm()
        }
    }
}
