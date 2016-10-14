//
//  UIViewController+Utility.swift
//  weatherApp
//
//  Created by StephenJang on 10/14/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import UIKit

public extension UIViewController {
    class func storyboard() -> UIStoryboard {
        return UIStoryboard(name:"Main", bundle:nil)
    }
    class func viewController() -> UIViewController {
        return storyboard().instantiateViewController(withIdentifier:self.className)
    }
}
