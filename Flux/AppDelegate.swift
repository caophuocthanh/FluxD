//
//  AppDelegate.swift
//  Flux
//
//  Created by Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let window	= UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window = window
        
        self.window?.rootViewController = UINavigationController(rootViewController:ViewController())
        
        self.window?.makeKeyAndVisible()
        
        setup()
        
        return true
    }
    
    func setup() {
        
        print("\n\n----------------AppDelegate setup-------------------\n")
        
        let warehouse =  Store.defaultStore
        
        let a1 = NewModel(id: "a1", create_at: nil, name: "a1")
        let a2 = NewModel(id: "a2", create_at: nil, name: "a2")
        let a3 = NewModel(id: "a3", create_at: nil, name: "a3")
        let a4 = NewModel(id: "a4", create_at: nil, name: "a4")
        
        warehouse.append(a1, storeIndentifier: "1")
        warehouse.append(a2, storeIndentifier: "1")
        warehouse.append(a3, storeIndentifier: "1")
        warehouse.append(a4, storeIndentifier: "1")
        
        print("warehouse.getStore(): ", warehouse.getStore())
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

