//
//  SubModel.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 4/28/17.
//  Copyright © 2017 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class SubModel: Object {
    
    var name: Observable<String>!
    
    override init(_ any: Any) {
        super.init(any)
        if let idName = JSON(any)["name"].string {
            self.name = Observable<String>(idName)
        }
    }
}
