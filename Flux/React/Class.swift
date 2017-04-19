//
//  Class.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 4/19/17.
//  Copyright © 2017 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class Class {
    
    var id: Observable<String> = Observable<String>("")
    var createdAt: Observable<Date>? = Observable<Date>(Date())
    var updateAt: Observable<Date>? = Observable<Date>(Date())
}
