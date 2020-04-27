//
//  AppDelegate.swift
//  Videojuegos
//
//  Created by MIMO on 20/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?
        lazy var coreDataStack = CoreDataStack()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            //return true


            // Override point for customization after application launch
          //  let rootView: TableViewController = TableViewController()
    //
          //  if let window = self.window{
          //         window.rootViewController = rootView
          //  }
        //
        //    let navigationController = window!.rootViewController as! UINavigationController
        //    let viewController = navigationController.topViewController as! ViewController
            let viewController = window!.rootViewController as! ViewController

           // let viewController = window!.rootViewController as! TableViewController

            viewController.coreDataStack = coreDataStack
            return true
        }


        // MARK: UISceneSession Lifecycle

      //  func application(_ application: UIApplication, configurationForConnectin//connectingSceneSession: //UISceneSession, options: UIScene.ConnectionOptions) -//UISceneConfiguration {
      //      // Called when a new scene session is being created.
      //      // Use this method to select a configuration to create the new scene with.
      //      return UISceneConfiguration(name: "Default Configuration", sessionRole////connectingSceneSession.role)
      //
      //  }

      //  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions////Set<UISceneSession>) {
      //      // Called when the user discards a scene session.
      //      // If any sessions were discarded while the application was not running, this will b//called //shortly after application:didFinishLaunchingWithOptions.
      //      // Use this method to release any resources that were specific to the discarded scenes//as they //will not return.
      //  }

        func applicationDidEnterBackground(_ application: UIApplication) {
            coreDataStack.saveContext()
        }

        func applicationWillTerminate(_ application: UIApplication) {
            coreDataStack.saveContext()
        }

    

}

