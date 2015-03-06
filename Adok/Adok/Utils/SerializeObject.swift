//
//  SerializeObject.swift
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

extension Array {
    func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

class SerializeObject: NSObject {
    
    class func convertJsonToObject(jsonDictionary: NSDictionary!, classObjectResponse: String) -> AnyObject! {
        println("dico : \(jsonDictionary)")
        if let obj: AnyObject = createObjectWithName(classObjectResponse as NSString as! String) as AnyObject? {
            var propritiesObj: Array<String> = Array()
            for var index = 0; index < reflect(obj).count; index++ {
                propritiesObj.append(reflect(obj)[index].0)
            }
            for currentKey in jsonDictionary.allKeys as! [String] {
                if let currentObjectValue: AnyObject = jsonDictionary.objectForKey(currentKey) {

                    println("current key : \(currentKey)")
                    println("current value : \(currentObjectValue)")
                    if propritiesObj.contains(currentKey) {
                        if currentObjectValue is Int {
                            obj.setValue(NSNumber(integer: currentObjectValue as! Int), forKey: currentKey)
                        }
                        else if currentObjectValue is String {
                            obj.setValue(jsonDictionary.objectForKey(currentKey) as! String, forKey: currentKey)
                        }
                    }
                }
            }
            return obj
        }
        return nil
    }
    
    class func convertObjectToJson(object: AnyObject!) -> NSDictionary! {
        if (object == nil || reflect(object).count == 0) {
            return nil
        }
        var jsonDictionary = NSMutableDictionary()
        for (var index = 0; index < reflect(object).count; index++) {
            if reflect(object)[index].1.value is String {
                jsonDictionary.setValue(reflect(object)[index].1.value as! String, forKey: reflect(object)[index].0)
            }
            else if reflect(object)[index].1.value is Int {
                jsonDictionary.setValue(reflect(object)[index].1.value as! Int, forKey: reflect(object)[index].0)
            }
            else if reflect(object)[index].1.value is Array<String> {
                jsonDictionary.setValue(reflect(object)[index].1.value as! Array<String>, forKey: reflect(object)[index].0)
            }
        }
        return jsonDictionary
    }
    
}
