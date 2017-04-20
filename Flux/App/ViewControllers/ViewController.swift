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
        
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        print("\n\n-----------------ViewController viewDidLoad-----------------\n")
        
        let ware =  Store.mainStore
        let a = ware.fetch("1").value
        
        print("ware.fetch:", a)
        
        if let newmodel = a.objects.value.first?.value as? NewModel {
            
            print(newmodel.self)
            print("before ac.model.id.reacts:", newmodel.name.events)
            
            newmodel.name.subscribe { [weak self] in
                print("\n\n", self ?? ""," =======>>>>> react A: ",$0)
            }
            
            print("ac.model.id.value:", newmodel.name.value)
            print("ac.model.id.reacts:", newmodel.name.events)
            
            
            print("------SET VALUE")
            newmodel.name.value = "SET ID :YAFHJDGFJAHDGFAJDHGFDA"
        }
        
        
        /// /////////////////////////////////////////////////////////////
        
        let delayTime0 = DispatchTime.now() + Double(Int64(5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime0) {
            self.navigationController?.pushViewController(BViewController(), animated: true)
        }
        
        
        let atest: Observable<[String]> = Observable<[String]>([])
        
        atest.subscribe { [weak self] in
            print(self ?? "" ," \n\n=======>>>>> react TEST A COUNT: ",$0.count, "\n")
        }
        
        
        print("------START-----")
        for i in 0..<10 {
            autoreleasepool {
                atest.value.append("djfdjhkxhkdsjhfgsdfsdkjf" + "\(i)")
            }
        }
        print("------END-------")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear A")
        
        print("\n\n----------------ViewController viewDidAppear-------------------\n")
        
        let delayTime0 = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime0) {
            let ware =  Store.mainStore
            let a = ware.fetch("1").value
                        
            print("ware.fetch:", a)
            
            if let newmodel = a.objects.value.first?.value as? NewModel {
                print(newmodel.self)
                
                print("ac.model.id.value:", newmodel.name.value)
                print("ac.model.id.reacts:", newmodel.name.events)
                
                
                print("------SET VALUE")
                newmodel.name.value = "SET ID :YAFHJDGFJAHDGFAJDHGFDAzxczxczxczxczxczxczxccsakhgfkjhsadgfkjhasd"
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    deinit {
        print("deinit: ",self )
    }
}

