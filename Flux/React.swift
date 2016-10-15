//
//  React.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* React */
class React<T> {
    
    typealias Listener = T -> ()
    
    var listener: Listener
    
    init(_ listener: Listener) {
        self.listener = listener
    }
    
    func bind(genenic: Genenic<T>) {
        genenic.reacts.append(ReactBox(self))
    }
}