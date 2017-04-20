//
//  NewModel.swift
//  Flux
//
//  Created by Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class NewModel: Object {
    
    var name = Observable<String>("")
    
    required init(id: String, createAt: Date?, name: String) {
        super.init()
        self.id.value = id
        if let _create_at = createAt {
            self.createdAt?.value = _create_at
        }
        self.name.value = name
    }
    
    required init() {
        super.init()
    }
}
