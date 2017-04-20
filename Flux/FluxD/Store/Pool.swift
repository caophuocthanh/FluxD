//
//  StoreModel.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit
import Foundation

class Pool {
    
    /*
     * public properties
     */
    var identifer: String!
    
    var objects: Observable<[Observable<Object>]> = Observable<[Observable<Object>]>([])
    
    var array: [Observable<Object>] {
        get {
            return self.objects.value
        }
        set{}
    }
    
    /*
     * init
     */
    init(_ identifer: String,_ object: Object? = nil ) {
        if let object = object {
            self.objects.value.append(Observable<Object>(object))
        }
        self.identifer = identifer
    }
    
    /*
     * subscribe
     */
    typealias ModelsHandler = ([Observable<Object>]) -> ()
    
    func subscribe(_ modelsHandler: @escaping ModelsHandler) {
        self.objects.subscribe(modelsHandler)
    }
    
    /*
     * append
     */
    
    func append(_ object: Object) {
        return self.objects.value.append(Observable<Object>(object))
    }
    
    /*
     * remove at index
     */
    func remove(_ index: Int) {
        self.objects.value.remove(at: index)
    }
    
    
    /*
     * remove by id and type
     */
    func remove(_ id: String, type: AnyClass) {
        for (index, observableObject) in self.objects.value.enumerated() {
            if observableObject.value.id.value == id,  type(of: observableObject.value) === type {
                self.objects.value.remove(at: index)
            }
        }
    }
    
    /*
     * update
     */
    func update(_ object: Object) {
        for observableObject in self.objects.value {
            if observableObject.value.id.value == object.id.value,  type(of: observableObject.value) === type(of: object) {
                return observableObject.value = object
            }
        }
    }
    
    /*
     * filter
     */
    func filter<T: Object>(_ id: String, type: T.Type) -> T? {
        for observableObject in self.objects.value {
            if observableObject.value.id.value == id && type(of: observableObject.value) === type {
                return observableObject as? T
            }
        }
        return nil
    }
    
}
