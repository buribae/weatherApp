//
//  Model.swift
//  weatherApp
//
//  Created by StephenJang on 10/13/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import Foundation

open class Model: NSObject {
    
    static let INVALID_INT_VALUE: Int = -1
    
    open var json: [String:Any]?
    
    open var uniqueId: String {
        fatalError("Must Override")
    }
    
    public required init?(_ json: [String:Any]) {
        super.init()
        self.json = json
    }
    
    open class func stringify(_ input:Any?) -> String{
        guard let input = input else { return "" }
        return String(describing:input)
    }
    
    open class func objectsFromArray(_ jsonArray: Array<[String:Any]>) -> [Model] {
        var objects = [] as [Model]
        for json in jsonArray {
            if let object = self.init(json) as Model! {
                objects.append(object)
            }
        }
        return objects
    }
    
}
