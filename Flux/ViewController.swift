//
//  ViewController.swift
//  Flux
//
//  Created by Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        print("\n\n-----------------ViewController viewDidLoad-----------------\n")
        
        let ware =  Store.defaultStore
        let a = ware.fetch("1")
        
        print("ware.fetch:", a)
        
        let newmodel: NewModel = a[0].model as! NewModel
        print(newmodel.self)
        print("before ac.model.id.reacts:", newmodel.name.reacts)
        
        React<String> { [weak self] in
            print(self," =======>>>>> react A: ",$0)
            }.bind(newmodel.name)
        
        print("ac.model.id.value:", newmodel.name.value)
        print("ac.model.id.reacts:", newmodel.name.reacts)
        
        
        print("------SET VALUE")
        newmodel.name.value = "SET ID :YAFHJDGFJAHDGFAJDHGFDA"
        
        /// /////////////////////////////////////////////////////////////
        
        let delayTime0 = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime0, dispatch_get_main_queue()) {
            self.navigationController?.pushViewController(BViewController(), animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear A")
        
        print("\n\n----------------ViewController viewDidAppear-------------------\n")
        
        let delayTime0 = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime0, dispatch_get_main_queue()) {
            let ware =  Store.defaultStore
            let a = ware.fetch("1")
            
            print("ware.fetch:", a)
            
            let newmodel: NewModel = a[0].model as! NewModel
            print(newmodel.self)
            
            print("ac.model.id.value:", newmodel.name.value)
            print("ac.model.id.reacts:", newmodel.name.reacts)
            
            
            print("------SET VALUE")
            newmodel.name.value = "SET ID :YAFHJDGFJAHDGFAJDHGFDA"
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    deinit {
        print("deinit: ",self )
    }
}

