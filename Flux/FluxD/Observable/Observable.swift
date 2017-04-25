//
//  Observable.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import Foundation

/* Dynamic */
class Observable<ElementType> {
    
    typealias EventHandler = (ElementType) -> ()
    
    var value: ElementType {
        didSet {
            for (index, eventBox) in self.events.enumerated() {
                print("eventBox.event:", eventBox.event ?? "nil")
                guard let event = eventBox.event else {
                    self.events.remove(at: index)
                    return
                }
                guard let _ = eventBox.dispose else {
                    print("remove event with target was deinit...")
                    self.events.remove(at: index)
                    return
                }
                event.fire(self.value)
            }
        }
    }
    
    var events: [EventBox<ElementType>] = []
    
    init(_ value: ElementType) {
        self.value = value
    }
    
    func subscribe(_ event: @escaping EventHandler, disposeIn dispose: AnyObject) {
        Event<ElementType> { (observable) in
            event(observable)
            }.push(self, dispose)
    }
    
    deinit {
        print("Observable deinit:", self)
    }
    
}
