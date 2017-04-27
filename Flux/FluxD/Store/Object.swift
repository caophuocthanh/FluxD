//
//  Model.swift
//  Flux
//
//  Created by Cao Phuoc Thanh on 6/30/16.
//  Copyright © 2016 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

/*
 * Object
 */
class Object: Class {
    
    var id: Observable<Int>!
    
    var createdTime: Observable<String>!
    var updatedTime: Observable<String>!
    
    init(_ any: Any) {
        super.init()
        self.map(any)
    }
    
    func map(_ any: Any) {
        if let idValue = JSON(any)["id"].int {
            self.id = Observable<Int>(idValue)
        }
        if let createdTimeValue = JSON(any)["createdTime"].string {
            self.createdTime = Observable<String>(createdTimeValue)
        }
        if let updatedTimeValue = JSON(any)["updatedTime"].string {
            self.updatedTime = Observable<String>(updatedTimeValue)
        }
    }
    
    
    func update(_ model: Object) {
        
        let mirrored_object_old = Mirror(reflecting: self)
        let mirrored_object_new = Mirror(reflecting: model)
        
        for (_, element_old) in mirrored_object_old.children.enumerated() {
            for (_, element_new) in mirrored_object_new.children.enumerated() {
                if element_old.label == element_new.label {
                    if let object = element_old.value as? Object {
                        object.update(element_new.value as! Object)
                    } else {
                        if let oldValue = element_old.value as? Observable<String>, let newValue = element_new.value as? Observable<String> {
                            oldValue.value = newValue.value
                        }
                        if let oldValue = element_old.value as? Observable<Int>, let newValue = element_new.value as? Observable<Int> {
                            oldValue.value = newValue.value
                        }
                        if let oldValue = element_old.value as? Observable<Double>, let newValue = element_new.value as? Observable<Double> {
                            oldValue.value = newValue.value
                        }
                        if let oldValue = element_old.value as? Observable<Bool>, let newValue = element_new.value as? Observable<Bool> {
                            oldValue.value = newValue.value
                        }
                        if let oldValue = element_old.value as? Observable<Date>, let newValue = element_new.value as? Observable<Date> {
                            oldValue.value = newValue.value
                        }
                        if let oldValue = element_old.value as? Observable<Float>, let newValue = element_new.value as? Observable<Float> {
                            oldValue.value = newValue.value
                        }
                    }
                }
            }
        }
        
        if let parent_old = mirrored_object_old.superclassMirror, let parent_new = mirrored_object_new.superclassMirror {
            for (_, element_old) in parent_old.children.enumerated() {
                for (_, element_new) in parent_new.children.enumerated() {
                    if element_old.label == element_new.label {
                        if let object = element_old.value as? Object {
                            object.update(element_new.value as! Object)
                        } else {
                            if let oldValue = element_old.value as? Observable<String>, let newValue = element_new.value as? Observable<String> {
                                oldValue.value = newValue.value
                            }
                            if let oldValue = element_old.value as? Observable<Int>, let newValue = element_new.value as? Observable<Int> {
                                oldValue.value = newValue.value
                            }
                            if let oldValue = element_old.value as? Observable<Double>, let newValue = element_new.value as? Observable<Double> {
                                oldValue.value = newValue.value
                            }
                            if let oldValue = element_old.value as? Observable<Bool>, let newValue = element_new.value as? Observable<Bool> {
                                oldValue.value = newValue.value
                            }
                            if let oldValue = element_old.value as? Observable<Date>, let newValue = element_new.value as? Observable<Date> {
                                oldValue.value = newValue.value
                            }
                            if let oldValue = element_old.value as? Observable<Float>, let newValue = element_new.value as? Observable<Float> {
                                oldValue.value = newValue.value
                            }
                        }
                    }
                }
            }
        }
    }
    
    func string() -> String {
        let data = try! JSONSerialization.data(withJSONObject: self.toJSON(), options: JSONSerialization.WritingOptions.prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return (string ?? "nil") as String
    }
    
    func toJSON() -> [String: Any] {
        
        var properties    = [String: Any]()
        let mirrored_object = Mirror(reflecting: self)
        for (_, element) in mirrored_object.children.enumerated() {
            if let label = element.label {
                if let object = element.value as? Object {
                    properties[label] = object.toJSON()
                } else {
                    properties[label] = element.value
                }
            }
        }
        
        if let parent = mirrored_object.superclassMirror {
            for (_, element) in parent.children.enumerated() {
                if let label = element.label {
                    if let object = element.value as? Object {
                        properties[label] = object.toJSON()
                    } else {
                        properties[label] = element.value
                    }
                }
            }
        }
        return properties
    }
}
