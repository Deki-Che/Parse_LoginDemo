//
//  AppDelegate.swift
//  LoginDemo
//
//  Created by Deki on 15/11/12.
//  Copyright © 2015年 Deki. All rights reserved.


import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Parse 配置
        Parse.enableLocalDatastore()
        
        // 初始化 Parse
        Parse.setApplicationId("Wa5Sp8lMUMaKm9wpIKPgd5pUgAxAmbkoMDDOOon9", clientKey: "0RBy9ZKI0tDtnl0vsfsx0EzjTwRRh4Yu7Q2WaHw2")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        let userName :String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if userName != nil {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let main:MainViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
            let mainNav = UINavigationController(rootViewController: main)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self.window?.rootViewController = mainNav

        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

