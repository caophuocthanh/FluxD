//
//  ReactBox.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* ReactBox */
class EventBox<ElementEventType> {
    
    var event: Event<ElementEventType>?
    weak var dispose: AnyObject?
    
    init(_ event: Event<ElementEventType>,_ dispose: AnyObject) {
        self.event = event
        self.dispose = dispose
    }
    
    deinit {
        print("EventBox deinit:", self)
    }
}
