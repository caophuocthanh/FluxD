//
//  React.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* React */
class Event<Element> {

    typealias Listener = (Element) -> ()
    
    var listener: Listener
    
    init(_ listener: @escaping Listener) {
            self.listener = listener
    }
    
    func on(_ observable: Observable<Element>) {
        observable.events.append(EventBox(self))
    }
    
}
