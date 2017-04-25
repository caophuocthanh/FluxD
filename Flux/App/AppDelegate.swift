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
        
        let warehouse =  Store.mainStore
        
        print("WAREHOUSE: ", warehouse.rawValue)
        
        warehouse.subscribe("1", { [unowned self] (new) in
            print(self, ": subscribe UPDATE STORE 1:", new)
        }, disposeIn: self)
        
        warehouse.subscribe("11", { [unowned self] (new) in
            print(self, ": subscribe UPDATE STORE 11:", new)
        }, disposeIn: self)
        
        
        let a1 = NewModel(id: "a1", createAt: nil, name: "a1")
        let a2 = NewModel(id: "a2", createAt: nil, name: "a2")
        let a3 = NewModel(id: "a3", createAt: nil, name: "a3")
        let a4 = NewModel(id: "a4", createAt: nil, name: "a4")
        
        let a11 = NewModel(id: "a11", createAt: nil, name: "a11")
        let a21 = NewModel(id: "a21", createAt: nil, name: "a21")
        let a31 = NewModel(id: "a31", createAt: nil, name: "a31")
        let a41 = NewModel(id: "a41", createAt: nil, name: "a41")
        
        warehouse.append(a1, poolIdentifier: "1")
        warehouse.append(a2, poolIdentifier: "1")
        warehouse.append(a3, poolIdentifier: "1")
        warehouse.append(a4, poolIdentifier: "1")
        
        warehouse.append(a11, poolIdentifier: "1")
        warehouse.append(a21, poolIdentifier: "1")
        warehouse.append(a31, poolIdentifier: "1")
        warehouse.append(a41, poolIdentifier: "1")
        
        
        
        warehouse.append(a1, poolIdentifier: "11")
        warehouse.append(a2, poolIdentifier: "11")
        warehouse.append(a3, poolIdentifier: "11")
        warehouse.append(a4, poolIdentifier: "11")
        warehouse.append(a11, poolIdentifier: "11")
        warehouse.append(a21, poolIdentifier: "11")
        warehouse.append(a31, poolIdentifier: "11")
        warehouse.append(a41, poolIdentifier: "11")
        
        print("\n\nwarehouse.store: ", warehouse.observableStore)
        
        print("\n\n\nwarehouse.rawValue: ", warehouse.rawValue)
        
        print("warehouse 1", warehouse.fetch("1"))
        
        print("warehouse 11", warehouse.fetch("11"))
        
        a1.name.subscribe({ [unowned self] (value) in
            print(self, ": A1 CHHANGE:", value)
        }, disposeIn: self)
        
        let aa = warehouse.fetch("11").value.filter("a1", type: NewModel.self)
        
        aa?.name.subscribe ({ [unowned self] (value) in
            print(self,": \n\nAA CHHANGE:", value)
        }, disposeIn: self)
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

