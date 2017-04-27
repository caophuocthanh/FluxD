//
//  NewModel.swift
//  Flux
//
//  Created by Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class NewModel: Object {
    
    var name: Observable<String>!
    var sub: Observable<SubModel>!
    
    override init(_ any: Any) {
        super.init(any)
        if let idName = JSON(any)["name"].string {
            self.name = Observable<String>(idName)
        }
        if let sub = JSON(any)["sub"].dictionaryObject {
            self.sub = Observable<SubModel>(SubModel(sub))
        }
    }
    
}
