//
//  ViewController.swift
//  Flux
//
//  Created by Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let tableBiew: UITableView = UITableView()
    
    
    var data: [Observable<Object>] = []
    
    typealias HandleUpdateDataDelay = (_ data: [Observable<Object>]) -> ()
    var handleUpdateDataDelay: HandleUpdateDataDelay?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        self.view = tableBiew
        
        tableBiew.dataSource = self
        tableBiew.delegate = self
        
        tableBiew.register(UITableViewCell.self, forCellReuseIdentifier: "aa")
        
        // Do any additional setup after loading the view, typically from a nib.
        
        Queue.delay(10) {
            Store.main.fetch("1") { (pool) in
                print("LSKJFGLJSHGLFJHSGFLJHSFJHSFGLSFJH:", pool.value.objects.value)
                self.data = pool.value.objects.value
                self.tableBiew.reloadData()
            }
        }
        
        Store.main.subscrible(1, dispose: self, poolId: "1") { (observer) in
            self.data = observer
            self.tableBiew.reloadData()
            print("Reload success: ", observer.count)
        }
        
        print("\n\n-----------------ViewController viewDidLoad-----------------\n")
        
        /// /////////////////////////////////////////////////////////////
        
        //        let delayTime0 = DispatchTime.now() + Double(Int64(5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        //        DispatchQueue.main.asyncAfter(deadline: delayTime0) {
        //            self.navigationController?.pushViewController(BViewController(), animated: true)
        //        }
        
        
        let atest: Observable<[String]> = Observable<[String]>([])
        
        atest.subscribe(self) { [unowned self] in
            print(self ," \n\n=======>>>>> react TEST A COUNT: ",$0.count, "\n")
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
        
        

        Queue.delay(15) {
            Queue.global {
                for i in 0..<100 {
                    let a1 = NewModel(["id" : i , "name": "thanh \(i)", "sub": ["id" : i , "name": "thanh\(i)"]])
                    Store.main.add(a1, poolId: "1")
                }
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


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "aa", for: indexPath)
        if let observerModel = (self.data[indexPath.row].value as? NewModel) {
            cell.textLabel?.text = observerModel.name.value
            observerModel.sub.value.name.subscribe(self, { (newValue) in
                print("observerModel.name changed:", newValue)
                cell.textLabel?.text = newValue
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (data[indexPath.row].value as? NewModel)?.name.value = "Changed: \(indexPath.row)"
    }
    
}

