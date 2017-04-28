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
    
    var id: Observable<Int?> = Observable<Int?>(nil)
    var createdTime: Observable<String?> = Observable<String?>(nil)
    var updatedTime: Observable<String?> = Observable<String?>(nil)
    
    init(_ any: Any) {
        super.init()
        self.map(any)
    }
    
    func map(_ any: Any) {
        if let idValue = JSON(any)["id"].int {
            self.id = Observable<Int?>(idValue)
        }
        if let createdTimeValue = JSON(any)["createdTime"].string {
            self.createdTime = Observable<String?>(createdTimeValue)
        }
        if let updatedTimeValue = JSON(any)["updatedTime"].string {
            self.updatedTime = Observable<String?>(updatedTimeValue)
        }
    }
    
    
    func update(_ model: Object) {
        
        let mirrored_object_old = Mirror(reflecting: self)
        let mirrored_object_new = Mirror(reflecting: model)
        
        for (_, element_old) in mirrored_object_old.children.enumerated() {
            for (_, element_new) in mirrored_object_new.children.enumerated() {
                if element_old.label == element_new.label {
                    self.updateObservable(element_old, element_new)
                }
            }
        }
        
        if let parent_old = mirrored_object_old.superclassMirror, let parent_new = mirrored_object_new.superclassMirror {
            for (_, element_old) in parent_old.children.enumerated() {
                for (_, element_new) in parent_new.children.enumerated() {
                    self.updateObservable(element_old, element_new)
                }
            }
        }
    }
    
    fileprivate func mapObservable<T: Any>(_ type: T.Type,_ oldObservable:(label: String?, value: Any),_ newObservable:(label: String?,value: Any)) -> Bool {
        print("MAPP TYPE:", type)
        if let oldValue = oldObservable.value as? Observable<T?>, let newValue = newObservable.value as? Observable<T?> {
            oldValue.value = newValue.value
            return true
        }
        return false
    }
    
    fileprivate func updateObservable(_ oldObservable:(label: String?, value: Any),_ newObservable:(label: String?,value: Any)) {
        if oldObservable.label == newObservable.label {
            if self.mapObservable(String.self, oldObservable, newObservable) { return }
            else if self.mapObservable(Int.self, oldObservable, newObservable) { return }
            else if self.mapObservable(Double.self, oldObservable, newObservable) { return }
            else if self.mapObservable(Bool.self, oldObservable, newObservable) { return }
            else if self.mapObservable(Date.self, oldObservable, newObservable) { return }
            else if self.mapObservable(Float.self, oldObservable, newObservable) { return }
            else if self.mapObservable(Object.self, oldObservable, newObservable) {return}
            else if self.mapObservable(SubModel.self, oldObservable, newObservable) {return}
            else if self.mapObservable(NewModel.self, oldObservable, newObservable) {return}
            print("Please add Object Type to this Code:", oldObservable," : ", newObservable)
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
