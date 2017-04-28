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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window	= UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        self.window?.rootViewController = UINavigationController(rootViewController:ViewController())
        
        self.window?.makeKeyAndVisible()
        
        setup()
        
        return true
    }
    
    func setup() {
        
        print("\n\n----------------AppDelegate setup-------------------\n")
        
        let warehouse =  Store.main
        
        print("WAREHOUSE: ", warehouse.rawValue)
        
        warehouse.subscribe(self, poolId: "1") { [unowned self] (new) in
            print(self, ": subscribe UPDATE STORE 11:", new)
        }
        
        
        let a1 = NewModel(["id" : 1 , "name": "thanh1AAAA"])
        let a2 = NewModel(["id" : 2 , "name": "thanh2AAA", "sub": ["id" : 2 , "name": "thanh2AAAAAA"]])
        let a3 = NewModel(["id" : 3 , "name": "thanh3AAA", "sub": ["id" : 3 , "name": "thanh3AAAAAA"]])
        let a4 = NewModel(["id" : 4 , "name": "thanh4AAA", "sub": ["id" : 4 , "name": "thanh4AAAAAA"]])
        
        warehouse.add(a1, poolId: "1")
        warehouse.add(a2, poolId: "1")
        warehouse.add(a3, poolId: "1")
        warehouse.add(a4, poolId: "1")
        
        Queue.delay(1) { 
            let a11 = NewModel(["id" : 11 , "name": "thanh11BBB", "sub": ["id" : 11 , "name": "thanh11BBBBB"]])
            let a21 = NewModel(["id" : 12 , "name": "thanh12BBB", "sub": ["id" : 12 , "name": "thanh12BBBBB"]])
            let a31 = NewModel(["id" : 13 , "name": "thanh13BBB", "sub": ["id" : 13 , "name": "thanh13BBBBB"]])
            let a41 = NewModel(["id" : 14 , "name": "thanh14BB", "sub": ["id" : 12 , "name": "thanh14BBBBB"]])
            
            warehouse.add(a11, poolId: "1")
            warehouse.add(a21, poolId: "1")
            warehouse.add(a31, poolId: "1")
            warehouse.add(a41, poolId: "1")
        }
        
        print("\n\nwarehouse.store: ", warehouse.observableStore)
        
        print("\n\n\nwarehouse.rawValue: ", warehouse.rawValue)
        
        a1.name.subscribe(self) { [unowned self] (value) in
            print(self, ": A1 CHHANGE:", value ?? "nil")
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

