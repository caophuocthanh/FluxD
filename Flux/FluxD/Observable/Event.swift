//
//  React.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* React */
class Event<ElementType> {
    
    typealias EventListener = (ElementType, ElementType) -> ()
    
    private var _eventListener: EventListener
    
    init(_ eventListener: @escaping EventListener) {
        self._eventListener = eventListener
    }
    
    func on(_ observable: Observable<ElementType>) {
        observable.events.append(EventBox(self))
    }
    
    func onChange(_ elementOld: ElementType, _ elementNew: ElementType) {
        self._eventListener(elementOld, elementNew)
    }
    
//    deinit {
//        print("Event deinit:", self)
//    }
    
}
