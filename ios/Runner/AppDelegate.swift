import UIKit
import Flutter
import YandexMapsMobile

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
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}