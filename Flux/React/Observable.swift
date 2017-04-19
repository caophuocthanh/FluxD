//
//  Observable.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import Foundation

/* Dynamic */
class Observable<Element> {
    
    var value: Element {
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
    
    var events: [EventBox<Element>] = []
    
    init(_ value: Element) {
        self.value = value
    }
    
    func subscribe(_ handle: @escaping (Observable<Element>) -> ()) {
        Event<Element> {(value) in
            handle(Observable<Element>(value))
            }.on(self)
    }
    
}
