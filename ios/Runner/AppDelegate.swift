import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {//通知推送

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   if #available(iOS 10.0, *) {//在前台不显示通知
          UNUserNotificationCenter.current().delegate = self
      }

      if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
              (granted, error) in
              if granted {
                  print("Notification permission granted")
              } else {
                  print("Notification permission denied")
              }
          }
      } else {
          // Fallback on earlier versions
          let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
      }
      GeneratedPluginRegistrant.register(withRegistry: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
