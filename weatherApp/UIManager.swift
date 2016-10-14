//
//  UIManager.swift
//  weatherApp
//
//  Created by StephenJang on 10/13/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import UIKit

class UIManager {
    static let sharedInstance = UIManager()
    fileprivate var imageList: [String:String] = [
        "01d":"art_clear.png",
        "01n":"ic_clear.png",
        "02d":"art_light_clouds.png",
        "02n":"ic_light_clouds.png",
        "03d":"art_clouds.png",
        "03n":"ic_cloudy.png",
        "04d":"art_clouds.png",
        "04n":"ic_cloudy.png",
        "09d":"art_light_rain.png",
        "09n":"ic_light_rain.png",
        "10d":"art_rain.png",
        "10n":"ic_rain.png",
        "11d":"art_storm.png",
        "11n":"ic_storm.png",
        "13d":"art_snow.png",
        "13n":"ic_snow.png",
        "50d":"art_fog.png",
        "50n":"ic_fog.png"
    ]
    
    init(){
        //Initalization
    }
    
    func getImageById(_ id:String) -> UIImage? {
        guard let image = imageList[id] else { return nil }
        return UIImage(named:image)!
    }
    
    fileprivate func rgbToUIColor(_ r:Double, g:Double, b:Double, alpha:Double? = 1.0) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha!))
    }
    
    func blueColor() -> UIColor {
        return rgbToUIColor(16, g:170, b:205)
    }
    
}
