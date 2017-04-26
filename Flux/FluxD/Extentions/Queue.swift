//
//  Queue.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 4/19/17.
//  Copyright © 2017 Cao Phuoc Thanh. All rights reserved.
//

import Dispatch
import Foundation


public struct Queue {
    
    static func delay(_ after: Double, _ block: @escaping (() -> ())) {
        let dispatchTime = DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            block()
        }
    }
    
    static func main (_ block: @escaping (() -> ())) {
        DispatchQueue.main.async {
            block()
        }
    }
    
    static func global(_ block: @escaping (() -> ())) {
        DispatchQueue.global().async {
            block()
        }
    }
    
    static func background(_ label: String ,_ block: @escaping (() -> ())) {
         DispatchQueue(label: label, attributes: .concurrent).async {
            block()
        }
    }
    
}
