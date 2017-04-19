//
//  Observable.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import Foundation

/* Dynamic */
class Observable<T> {
    
    var value: T {
        didSet {
            for (index, eventBox) in self.events.enumerated() {
                guard let event = eventBox.event else {
                    self.events.remove(at: index)
                    return
                }
                event.listener(value)
            }
        }
    }
    
    var events: [EventBox<T>] = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func subscribe(_ handle: @escaping (Observable<T>) -> ()) {
        Event<T> { (value) in
            handle(Observable<T>(value))
            }.bind(self)
    }
    
}
