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
    
    // TODO: What ?????
    //weak var react: React<ElementEventType>?
    var event: Event<ElementEventType>?
    
    init(_ event: Event<ElementEventType>) {
        self.event = event
    }
}
