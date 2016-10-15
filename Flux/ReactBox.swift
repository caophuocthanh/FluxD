//
//  ReactBox.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/28/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* ReactBox */
class ReactBox<T> {
    // TODO: Help me
    //weak var react: React<T>?
    var react: React<T>?
    
    init(_ react: React<T>) {
        self.react = react
    }
}
