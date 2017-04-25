//
//  BViewController.swift
//  Flux
//
//  Created by Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class BViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n----------------BViewController viewDidLoad-------------------\n")
        
        self.view.backgroundColor = UIColor.blue
        
        // Do any additional setup after loading the view.
        
        let ware =  Store.mainStore
        let a = ware.fetch("1").value
        
        print("ware.fetch:", a)
        
         if let newmodel = a.objects.value.first?.value as? NewModel {
            
            print(newmodel.self)
            print("before ac.model.id.reacts:", newmodel.name.events)

            newmodel.name.subscribe ({ [unowned self] (value) in
                print("\n\n (\(self)) =======>>>>> react B: ", value)
            } , disposeIn: self)

            print("ac.model.id.value:", newmodel.name.value)
            print("ac.model.id.reacts:", newmodel.name.events)
            
            
            print("------SET VALUE")
            newmodel.name.value = "SET ID :YAFHJDGFJAHDGFAJDHGFDA"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("viewDidDisappear B")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear B")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("viewWillDisappear B")
    }
    
    deinit {
        print("deinit: ",self )
    }
    
}
