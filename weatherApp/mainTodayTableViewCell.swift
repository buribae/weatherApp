//
//  mainTodayTableViewCell.swift
//  weatherApp
//
//  Created by StephenJang on 10/13/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import UIKit

class mainTodayTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 265.0
    
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
        
        dateLabel.text = weather?.dt
        tempMaxLabel.text = weather?.temp_max
        tempMinLabel.text = weather?.temp_min
        weatherLabel.text = weather?.main
        
        guard let icon = weather?.icon else { return }
        weatherImageView.image = UIImage(named: icon)
    }
    
    class func reuseIdentifier() -> String{
        return "mainTodayTableViewCell"
    }
}
