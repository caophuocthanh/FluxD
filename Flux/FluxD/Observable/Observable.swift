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
            Queue.global {
                for (index, eventBox) in self.events.enumerated() {
                    //print("eventBox.event:", eventBox.event ?? "nil")
                    guard let event = eventBox.event else {
                        self.events.remove(at: index)
                        return
                    }
                    guard let _ = eventBox.dispose else {
                        print("remove event with target was deinit...")
                        self.events.remove(at: index)
                        return
                    }
                    Queue.main {
                        event.fire(self.value)
                    }
                }
            }
        }
    }
    
    var events: [EventBox<ElementType>] = []
    
    init(_ value: ElementType) {
        self.value = value
    }
    
    func release(_ dispose: AnyObject, completion:@escaping (() -> ())) {
        Queue.global {
            for (index, eventBox) in self.events.enumerated() {
                guard let _dispose = eventBox.dispose else {
                    print("remove event with target was deinit...")
                    self.events.remove(at: index)
                    return
                }
                if _dispose === dispose {
                    self.events.remove(at: index)
                }
            }
            Queue.main {
                completion()
            }
        }
    }
    
    func subscribe(_ dispose: AnyObject, _ event: @escaping EventHandler) {
        self.release(dispose) {
            Event<ElementType> { (observable) in
                event(observable)
                }.push(self, dispose)
        }
    }
    
    deinit {
        //print("Observable deinit:", self)
    }
    
}
