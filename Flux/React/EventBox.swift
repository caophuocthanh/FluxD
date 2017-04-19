//
//  ReactBox.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* ReactBox */
class EventBox<Element> {
    // TODO: What ?????
    //weak var react: React<Element>?
    var event: Event<Element>?
    
    init(_ event: Event<Element>) {
        self.event = event
    }
}
