//
//  NewModel.swift
//  Flux
//
//  Created by Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class NewModel: Model {
    let name = Genenic<String>("")
    init(id: String, create_at: NSDate?, name: String) {
        super.init()
        self.id.value = id
        if let _create_at = create_at {
            self.created_at?.value = _create_at
        }
        self.name.value = name
    }
}