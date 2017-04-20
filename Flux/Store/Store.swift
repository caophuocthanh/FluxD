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
    
    fileprivate var store = Observable<[StoreModel]>([])
    
    func getStore() -> [StoreModel] {
        return self.store.value
    }
    
    func append(_ model: Model!, storeIndentifier: String) {
        if self.store.value.count > 0 {
            for value in self.store.value {
                if value.model?.value.id.value == model.id.value
                    && "\(value.model.self)" == "\(model.self)" {
                    value.model?.value = model
                    if !value.storeIndentifiers.contains(storeIndentifier) {
                        value.storeIndentifiers.append(storeIndentifier)
                    }
                    print("a: ", value.model?.value.id ?? "NULL")
                    return
                }
            }
        }
        
        let newStore = StoreModel(model, storeIndentifier: storeIndentifier)
        self.store.value.append(newStore)
        print("b: ", newStore.model?.value.id ?? "NULL")
        
    }
    
    func remove(_ model: Model, storeIndentifier: String) {
        for (index, value) in self.store.value.enumerated() {
            if value.model?.value.id.value == model.id.value
                && "\(value.model.self)" == "\(model.self)" {
                self.store.value.remove(at: index)
            } else {
                print("model with identifer \(model.id) not exits.")
            }
        }

    }
    
    func fetch(_ storeIndentifier: String) -> [StoreModel] {
        var arr = [StoreModel]()
        for value in self.store.value {
            for _storeIndentifier in value.storeIndentifiers {
                if _storeIndentifier == storeIndentifier {
                    arr.append(value)
                }
            }
        }
        return arr
    }
    
}
