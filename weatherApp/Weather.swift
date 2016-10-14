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
    open var week: String?
    
    public required init?(_ json:[String:Any] ) {
        guard let weather = json["weather"] as? Array<[String:Any]> else {return nil}
        guard let main = json["main"] as? [String:Any] else {return nil}
        guard let wind = json["wind"] as? [String:Any] else {return nil}
        guard let dt = json["dt"] as? TimeInterval else {return nil}
        id = Model.stringify(weather[0]["id"])
        
        super.init(json)
        
        // Check if id exists
        if self.uniqueId.isEmpty {
            return nil
        }
        
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        self.dt = dateFormatter.string(from: date)
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        switch dateFormatter.string(from: date) {
            case "Today","Tomorrow":
                self.week = dateFormatter.string(from: date)
                break
            default:
                self.week = self.dayOfWeek(date: date)
                break
        }
        
        
        self.name = Model.stringify(json["name"])
        self.main = Model.stringify(weather[0]["main"])
        self.desc = Model.stringify(weather[0]["description"])
        self.icon = Model.stringify(weather[0]["icon"])
        self.humidity = Model.stringify(main["humidity"])
        self.pressure = Model.stringify(main["pressure"])
        self.temp_max = "\((Model.stringify(main["temp_max"]) as NSString).substring(to: 2))°"
        self.temp_min = "\((Model.stringify(main["temp_min"]) as NSString).substring(to: 2))°"
        self.wind_speed = Model.stringify(wind["speed"])
        
    }
    
    // API has different structure!
    init?(_ json: [String:Any], isOther:Bool ){
        guard let weather = json["weather"] as? Array<[String:Any]> else {return nil}
        guard let temp = json["temp"] as? [String:Any] else {return nil}
        guard let dt = json["dt"] as? TimeInterval else {return nil}
        id = Model.stringify(weather[0]["id"])
        super.init(json)
        
        // Check if id exists
        if self.uniqueId.isEmpty {
            return nil
        }
        
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        self.dt = dateFormatter.string(from: date)
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        switch dateFormatter.string(from: date) {
        case "Today","Tomorrow":
            self.week = dateFormatter.string(from: date)
            break
        default:
            self.week = self.dayOfWeek(date: date)
            break
        }
        
        
        self.name = Model.stringify(json["name"])
        self.main = Model.stringify(weather[0]["main"])
        self.desc = Model.stringify(weather[0]["description"])
        self.icon = Model.stringify(weather[0]["icon"])
        self.humidity = Model.stringify(json["humidity"])
        self.pressure = Model.stringify(json["pressure"])
        self.temp_max = "\((Model.stringify(temp["max"]) as NSString).substring(to: 2))°"
        self.temp_min = "\((Model.stringify(temp["min"]) as NSString).substring(to: 2))°"
        self.wind_speed = Model.stringify(json["speed"])
    }
    
    override open var uniqueId: String {
        return id
    }
    
    func dayOfWeek(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    
}
