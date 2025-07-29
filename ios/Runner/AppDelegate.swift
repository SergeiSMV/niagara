import UIKit
import Flutter
import YandexMapsMobile
import JivoSDK
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        guard let dartDefinesString = Bundle.main.infoDictionary?["DART_DEFINES"] as? String else {
            print("DART_DEFINES not found")
            return false
        }
        
        var dartDefinesDictionary = [String:String]()
        for definedValue in dartDefinesString.components(separatedBy: ",") {
            guard let data = Data(base64Encoded: definedValue),
                let decoded = String(data: data, encoding: .utf8) else {
                print("Unable to decode defined value")
                continue
            }
            let values = decoded.components(separatedBy: "=")
            dartDefinesDictionary[values[0]] = values[1]
        }
        
        guard let apiKey = dartDefinesDictionary["YANDEX_MAPS"] else {
            print("YANDEX_MAPS not found")
            return false
        }
        
        YMKMapKit.setApiKey(apiKey)
        YMKMapKit.setLocale("ru_RU")

        UNUserNotificationCenter.current().delegate = self
        GeneratedPluginRegistrant.register(with: self)
        Jivo.notifications.handleLaunch(options: launchOptions)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Jivo.notifications.setPushToken(data: deviceToken)
        Messaging.messaging().apnsToken = deviceToken
    }
    
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Jivo.notifications.setPushToken(data: nil)
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let result = Jivo.notifications.didReceiveRemoteNotification(userInfo: userInfo) {
            completionHandler(result)
        }
        else {
            completionHandler(.noData)
        }
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let options = Jivo.notifications.willPresent(notification: notification, preferableOptions: .banner) {
            completionHandler(options)
        }
        else {
            completionHandler([])
        }
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Jivo.notifications.didReceive(response: response)
        completionHandler()
    }
}

extension Data {
    var hexDescription: String {
        return reduce("") { $0 + String(format: "%02x", $1) }
    }
}
