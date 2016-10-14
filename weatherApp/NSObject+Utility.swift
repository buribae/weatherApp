//
//  NSObject+Utility.swift
//  weatherApp
//
//  Created by StephenJang on 10/14/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import Foundation

public extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
