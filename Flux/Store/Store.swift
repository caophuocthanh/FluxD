//
//  Store.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/* Store */
class Store {
    
    static var defaultStore = Store()
    
    fileprivate var store = [StoreModel]()
    
    func getStore() -> [StoreModel] {
        return self.store
    }
    
    func append(_ model: Model!, storeIndentifier: String) {
        if self.store.count > 0 {
            for value in self.store {
                if value.model.id.value == model.id.value
                    && "\(value.model.self)" == "\(model.self)" {
                    value.model = model
                    if !value.storeIndentifiers.contains(storeIndentifier) {
                        value.storeIndentifiers.append(storeIndentifier)
                    }
                    print("a: ", value.model.id)
                    return
                }
            }
        }
        
        let newStore = StoreModel(model, storeIndentifier: storeIndentifier)
        self.store.append(newStore)
        print("b: ", newStore.model.id)
        
    }
    
    func remove(_ model: Model, storeIndentifier: String) {
        for (index, value) in self.store.enumerated() {
            if value.model.id.value == model.id.value
                && "\(value.model.self)" == "\(model.self)" {
                self.store.remove(at: index)
            } else {
                print("model with identifer \(model.id) not exits.")
            }
        }
    }
    
    func fetch(_ storeIndentifier: String) -> [StoreModel] {
        var arr = [StoreModel]()
        for value in self.store {
            for _storeIndentifier in value.storeIndentifiers {
                if _storeIndentifier == storeIndentifier {
                    arr.append(value)
                }
            }
        }
        return arr
    }
    
}
