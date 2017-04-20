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
    
    typealias EventHandler = (Observable<ElementType>, Observable<ElementType>) -> ()
    
    var value: ElementType {
        didSet {
            for (index, eventBox) in self.events.enumerated() {
                guard let event = eventBox.event else {
                    self.events.remove(at: index)
                    return
                }
                event.onChange(oldValue, value)
            }
        }
    }
    
    var events: [EventBox<ElementType>] = []
    
    init(_ value: ElementType) {
        self.value = value
    }
    
    func subscribe(_ event: @escaping EventHandler) {
        Event<ElementType> { (oldObservable, newObservable) in
            event(Observable<ElementType>(oldObservable) ,Observable<ElementType>(newObservable))
            }.on(self)
    }
    
//    deinit {
//        print("Observable deinit:", self)
//    }
    
}
