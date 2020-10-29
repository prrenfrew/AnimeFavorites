//
//  AppDelegate.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func applicationWillTerminate(_ application: UIApplication) {
    try? CoreDataManager.shared.context.save()
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    try? CoreDataManager.shared.context.save()
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}

