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
    func pool(_ poolId: String) -> Observable<Pool> {
        for observablePool in self._observableStore.value {
            if observablePool.value.identifer == poolId {
                return observablePool
            }
        }
        let observablePool = Observable<Pool>(Pool(poolId))
        self._observableStore.value.append(observablePool)
        return observablePool
    }
    
    /*
     * append
     */
    func add(_ object: Object, poolId: String) {
        for observablePool in self._observableStore.value {
            for observableObject in observablePool.value.array {
                if observableObject.value.id.value == object.id.value && type(of: observableObject.value) === type(of: object) {
                    observableObject.value.update(object)
                }
            }
        }
        let observablePool = self.pool(poolId)
        if observablePool.value.array.contains(where: { (observableObject) -> Bool in
            return observableObject.value.id.value == object.id.value && type(of: observableObject.value) == type(of: object)
        }) == false {
            return observablePool.value.append(object)
        }
    }
    
    func append(_ objects: [Object], poolId: String) {
        Queue.global {
            for object in objects {
                self.add(object, poolId: poolId)
            }
        }
    }
    
    /*
     * update
     */
    func update(_ object: Object) {
        Queue.global {
            for observablePool in self._observableStore.value {
                for observableObject in observablePool.value.array {
                    if observableObject.value.id.value == object.id.value && type(of: observableObject.value) === type(of: object) {
                        observableObject.value.update(object)
                    }
                }
            }
        }
    }
    
    /*
     * remove
     */
    func remove(_ object: Object, poolIdentifier: String) {
        Queue.global {
            for (index, observablePool) in self.rawValue.enumerated() {
                if observablePool.value.identifer == poolIdentifier {
                    self._observableStore.value.remove(at: index)
                }
            }
        }
    }
    
    func fetch(_ poolId: String) -> Observable<Pool> {
        for observablePool in self._observableStore.value {
            if observablePool.value.identifer == poolId {
                return observablePool
            }
        }
        let observablePool = Observable<Pool>(Pool(poolId))
        self._observableStore.value.append(observablePool)
        return observablePool
    }
    
    /*
     * fetch
     */
    func fetch(_ poolId: String,_ completion: @escaping (Observable<Pool>) -> ()) {
        Queue.global {
            for observablePool in self._observableStore.value {
                if observablePool.value.identifer == poolId {
                    Queue.main {
                        return completion(observablePool)
                    }
                }
            }
        }
    }
    
    /*
     * subscribe
     */
    typealias EventPoolHandler = ([Observable<Object>]) -> ()
    
    func subscribe(_ dispose: AnyObject, poolId id: String,_ eventPoolHandler: @escaping EventPoolHandler) {
        Queue.global {
            for observablePool in self._observableStore.value {
                if observablePool.value.identifer == id {
                    Queue.main {
                        return observablePool.value.subscribe(dispose,eventPoolHandler)
                    }
                }
            }
        }
    }
    
    func newPool(identifier id: String) {
        let observablePool = Observable<Pool>(Pool(id))
        self._observableStore.value.append(observablePool)
    }
    
    
    private var _eventPoolHandler: EventPoolHandler?
    
    func subscrible(_ delay: Double, dispose: AnyObject, poolId: String, _ eventPoolHandler: @escaping EventPoolHandler) {
        
        self._eventPoolHandler = { (observer) in
            Queue.main {
                eventPoolHandler(observer)
            }
        }
        
        var count = 0
        self.subscribe(dispose, poolId: poolId) { [weak self] (observer) in
            count += 1
            Queue.delay(delay) {
                count -= 1
                if count == 0 {
                    Queue.main {
                        self?._eventPoolHandler?(observer)
                    }
                }
            }
        }
    }
    
    
    /*
     * main store
     */
    static var main: Store = {
        let temp_store = Store()
        return temp_store
    }()
    
}
