//
//  Genenic.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

/* Dynamic */
class Genenic<T> {
    var value: T {
        didSet {
            for (index, reactBox) in self.reacts.enumerate() {
                guard let react = reactBox.react else {
                    self.reacts.removeAtIndex(index)
                    return
                }
                react.listener(value)
            }
        }
    }
    
    var reacts: [ReactBox<T>] = []
    
    init(_ value: T) {
        self.value = value
    }
}