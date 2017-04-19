//
//  React.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* React */
class Event<T> {

    typealias Listener = (T) -> ()
    
    var listener: Listener
    
    init(_ listener: @escaping Listener) {
            self.listener = listener
    }
    
    func bind(_ observable: Observable<T>) {
        observable.events.append(EventBox(self))
    }
    
}
