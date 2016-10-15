//
//  ViewController.swift
//  Flux
//
//  Created by Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let warehouse = Store()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let warehouse =  Store.defaultStore
        
        let a1 = NewModel(id: "a1", create_at: nil, name: "a1")
        let a2 = NewModel(id: "a1", create_at: nil, name: "a2")
        let a3 = NewModel(id: "a1", create_at: nil, name: "a3")
        let a4 = NewModel(id: "a1", create_at: nil, name: "a4")
        
        warehouse.append(a1, storeIndentifier: "1")
        warehouse.append(a2, storeIndentifier: "2")
        warehouse.append(a3, storeIndentifier: "3")
        warehouse.append(a4, storeIndentifier: "4")
        
        print(warehouse.getStore().last?.storeIndentifiers)
        
        print("\n\n----------------------------------\n")
        
        let ware =  Store.defaultStore
        let a = ware.fetch("1")
        
        print("ware.fetch:", a)
        
        let ac: NewModel = a[0].model as! NewModel
        
        print("ac.id.value:", ac.id.value)
        
        
        print(ac.self)
        let mc = React<String> {
            print("react A: ",$0)
        }
        
        mc.bind(ac.id)
        
        ac.name.value = "AHGKJHDGKHJDGKADHJ"
        
    /// ////////////////////////////////////////////////
        
        let delayTime1 = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime1, dispatch_get_main_queue()) {
            print("\n\n--------------------------\n")
            let v =  Store.defaultStore
            let z = v.fetch("1")
            let zc = z[0]
            
            print(zc.model.id.reacts)
            print(zc.model.id)
            
            zc.model.id.value = "asdasdasfasf"
        }
        
        
        
        let delayTime0 = dispatch_time(DISPATCH_TIME_NOW, Int64(10 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime0, dispatch_get_main_queue()) {
            print("\n\n--------------------------\n")
            let b = BViewController()
            self.navigationController?.pushViewController(b, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear")
    }
    
}

