//
//  StoreModel.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

class StoreModel {
    var storeIndentifiers = [String]()
    var model: Observable<Model>?
    init(_ model: Model, storeIndentifier: String) {
        self.model = Observable<Model>(model)
        self.storeIndentifiers.append(storeIndentifier)
    }
}
