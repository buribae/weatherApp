//
//  Weather.swift
//  weatherApp
//
//  Created by StephenJang on 10/13/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import Foundation

open class Weather: Model {
    
    open var id: String // Weather Id
    open var name: String? // Location Name
    open var dt: String? // Date
    open var temp_max: String?
    open var temp_min: String?
    open var main: String? // Main Description of weather
    open var desc: String? // Description of weather
    open var icon: String? // Weather Icon
    open var humidity: String?
    open var wind_speed: String?
    open var pressure: String?
    
    public required init?(_ json: [String:Any]) {
        guard let weather = json["weather"] as? Array<[String:Any]> else {return nil}
        guard let main = json["main"] as? [String:Any] else {return nil}
        guard let wind = json["wind"] as? [String:Any] else {return nil}
        id = Model.stringify(weather[0]["id"])
        
        super.init(json)
        
        // Check if id exists
        if self.uniqueId.isEmpty {
            return nil
        }
        
        self.name = Model.stringify(json["name"])
        self.dt = Model.stringify(json["dt"])
        self.main = Model.stringify(weather[0]["main"])
        self.desc = Model.stringify(weather[0]["description"])
        self.icon = Model.stringify(weather[0]["icon"])
        self.humidity = Model.stringify(main["humidity"])
        self.pressure = Model.stringify(main["pressure"])
        self.temp_max = "\((Model.stringify(main["temp_max"]) as NSString).substring(to: 2))°"
        self.temp_min = "\((Model.stringify(main["temp_min"]) as NSString).substring(to: 2))°"
        self.wind_speed = Model.stringify(wind["speed"])
        
    }
    
    override open var uniqueId: String {
        return id
    }
    
    
}
