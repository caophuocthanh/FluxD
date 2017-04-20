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
    
    typealias EventListener = (ElementType) -> ()
    
    fileprivate var _eventListener: EventListener
    
    init(_ eventListener: @escaping EventListener) {
        self._eventListener = eventListener
    }
    
    func on(_ observable: Observable<ElementType>){
        observable.events.append(EventBox(self))
    }
    
    func onChange(_ element: ElementType) {
        return self._eventListener(element)
    }
    
    deinit {
        print("Event deinit:", self)
    }
    
}
