//
//  AppDelegate.swift
//  DemoNoSwiftUI
//
//  Created by miao gaoliang on 2020/4/10.
//  Copyright © 2020 miao gaoliang. All rights reserved.
//

import UIKit
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 异常crash 捕获 https://stackoverflow.com/questions/36325140/how-to-catch-a-swift-crash-and-do-some-logging
//         https://developer.apple.com/library/archive/technotes/tn2151/_index.html#//apple_ref/doc/uid/DTS40008184-CH1-ANALYZING_CRASH_REPORTS-EXCEPTION_CODES
//  视频debug       https://developer.apple.com/videos/play/wwdc2018/414/
        NSSetUncaughtExceptionHandler { (exception) in
            let stack = exception.callStackReturnAddresses
            print("Stack trace: \(stack)")
        }
      
      // add log destinations. at least one is needed!
      let console = ConsoleDestination()  // log to Xcode Console
//      let file = FileDestination()  // log to default swiftybeaver.log file
//      let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123") // to cloud

      // use custom format and set console output to short time, log level & message
      console.format = "$DHH:mm:ss$d $L $M"
      // or use this for JSON output: console.format = "$J"

      // add the destinations to SwiftyBeaver
      log.addDestination(console)
//      log.addDestination(file)
//      log.addDestination(cloud)

      // Now let’s log!
      log.verbose("not so important")  // prio 1, VERBOSE in silver
      log.debug("something to debug")  // prio 2, DEBUG in green
      log.info("a nice information")   // prio 3, INFO in blue
      log.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
      log.error("ouch, an error did occur!")  // prio 5, ERROR in red

      // log anything!
      log.verbose(123)
      log.info(-123.45678)
      log.warning(Date())
      log.error(["I", "like", "logs!"])
      log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])

      // optionally add context to a log message
      console.format = "$L: $M $X"
      log.debug("age", context: 123)  // "DEBUG: age 123"
      log.info("my data", context: [1, "a", 2]) // "INFO: my data [1, \"a\", 2]"
        
      
      "张三".toPinyin()
      
      
//      let queue = DispatchQueue(label: "workqueue")
//      print("A")
//      queue.async {
//        print("B")
//      }
//      
//      queue.asyncAfter(deadline: .now() + .milliseconds(200)) {
//        queue.sync {
//          print("C")
//        }
//      }
//      
//      queue.asyncAfter(deadline: .now() + .milliseconds(100)) {
//        queue.async {
//          print("D")
//        }
//      }
//      
//      queue.sync {
//        print("E")
//      }
//      
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

