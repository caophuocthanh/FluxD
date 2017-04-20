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
            DispatchQueue.global(qos: .background).async {
                for (index, eventBox) in self.events.enumerated() {
                    guard let event = eventBox.event else {
                        self.events.remove(at: index)
                        return
                    }
                    DispatchQueue.main.async {
                        event.onChange(self.value)
                    }
                }
            }
        }
    }
    
    var events: [EventBox<ElementType>] = []
    
    init(_ value: ElementType) {
        self.value = value
    }
    
    func subscribe(_ event: @escaping EventHandler) {
        Event<ElementType> { (observable) in
            event(observable)
            }.on(self)
    }
    
    deinit {
        print("Observable deinit:", self)
    }
    
}
