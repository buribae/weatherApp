//
//  mainTodayTableViewCell.swift
//  weatherApp
//
//  Created by StephenJang on 10/13/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import UIKit

class mainTodayTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 250.0
    let uiManager = UIManager.sharedInstance
    
    // ________________________________________
    // MARK: Model
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    var weather: Weather? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let week = weather?.week, let dt = weather?.dt, let icon = weather?.icon else { return }
        dateLabel.text = "\(week), \(dt)"
        tempMaxLabel.text = weather?.temp_max
        tempMinLabel.text = weather?.temp_min
        weatherLabel.text = weather?.main
        
        weatherImageView.image = uiManager.getImageById(icon.substring(to:icon.index(before: icon.endIndex)) + "d")
    }
    
    class func reuseIdentifier() -> String{
        return "mainTodayTableViewCell"
    }
}
