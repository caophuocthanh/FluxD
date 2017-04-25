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
    
    fileprivate var _observableStore = Observable<[Observable<Pool>]>([])
    
    /*
     * observable store
     */
    var observableStore: Observable<[Observable<Pool>]> {
        set{}
        get{
            return self._observableStore
        }
    }
    
    /*
     * rawValue
     */
    var rawValue: [Observable<Pool>] {
        set{}
        get{
            return self._observableStore.value
        }
    }
    
    /*
     * observable pool
     */
    func observablePool(_ poolIdentifier: String) -> Observable<Pool> {
        for observablePool in self._observableStore.value {
            if observablePool.value.identifer == poolIdentifier {
                return observablePool
            }
        }
        let observablePool = Observable<Pool>(Pool(poolIdentifier))
        self._observableStore.value.append(observablePool)
        return observablePool
    }
    
    /*
     * append
     */
    func append(_ object: Object, poolIdentifier: String) {
        self.update(object)
        let observablePool = self.observablePool(poolIdentifier)
        if observablePool.value.array.contains(where: { (observableObject) -> Bool in
            return observableObject.value.id.value == object.id.value && type(of: observableObject.value) == type(of: object)
        }) == false {
            return observablePool.value.append(object)
        }
    }
    
    /*
     * update
     */
    func update(_ object: Object) {
        for observablePool in self._observableStore.value {
            for (index, observableObject) in observablePool.value.array.enumerated() {
                if observableObject.value.id.value == object.id.value && type(of: observableObject) === type(of: object) {
                    return observablePool.value.array[index].value = object
                }
            }
        }
    }
    
    /*
     * remove
     */
    func remove(_ object: Object, poolIdentifier: String) {
        for (index, observablePool) in self.rawValue.enumerated() {
            if observablePool.value.identifer == poolIdentifier {
                self._observableStore.value.remove(at: index)
            }
        }
    }
    
    /*
     * fetch
     */
    func fetch(_ poolIdentifier: String) -> Observable<Pool> {
        for observablePool in self._observableStore.value {
            if observablePool.value.identifer == poolIdentifier {
                return observablePool
            }
        }
        let observablePool = Observable<Pool>(Pool(poolIdentifier))
        self._observableStore.value.append(observablePool)
        return observablePool
    }
    
    /*
     * subscribe
     */
    typealias EventPoolHandler = ([Observable<Object>]) -> ()
    func subscribe(_ dispose: AnyObject, poolId id: String,_ eventPoolHandler: @escaping EventPoolHandler) {
        for observablePool in self._observableStore.value {
            if observablePool.value.identifer == id {
                return observablePool.value.subscribe(dispose,eventPoolHandler)
            }
        }
        let observablePool = Observable<Pool>(Pool(id))
        self._observableStore.value.append(observablePool)
        return observablePool.value.subscribe(dispose, eventPoolHandler)
    }
    
    /*
     * main store
     */
    static var mainStore: Store = {
        let temp_store = Store()
        return temp_store
    }()
    
}
