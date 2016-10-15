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
        
        self.view.backgroundColor = UIColor.blueColor()
        
        // Do any additional setup after loading the view.
        
        let ware =  Store.defaultStore
        let a = ware.fetch("1")
        
        print("ware.fetch:", a)
        
        let ac = a[0]
        
        print("before ac.model.id.reacts:", ac.model.id.reacts)
        print(ac.model.self)
        
        let mc = React<String> {
            print("=======>>>>> react B: ",$0)
        }
        mc.bind(ac.model.id)
        
        print("ac.id.value:", ac.model.id.value)
        print("ac.model.id.reacts:", ac.model.id.reacts)
        
        print("-------SET VALUE")
        
        ac.model.id.value = "SET ID :YAFHJDGFJAHDGFAJDHGFDA"

    }
    
    @IBOutlet weak var button: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear B")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear B")
    }

}
