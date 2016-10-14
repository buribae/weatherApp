//
//  detailViewController.swift
//  weatherApp
//
//  Created by StephenJang on 10/14/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    let uiManager = UIManager.sharedInstance
    
    var weather: Weather?
    func screenName() -> String { return "detail" }
    // ________________________________________
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Layout View
    func layoutView(){
        guard let icon = weather?.icon, let humidity = weather?.humidity, let pressure = weather?.pressure, let speed = weather?.wind_speed else { return }
        weekLabel.text = weather?.week
        dateLabel.text = weather?.dt
        tempMaxLabel.text = weather?.temp_max
        tempMinLabel.text = weather?.temp_min
        humidityLabel.text = "Humidity: \(humidity) %"
        pressureLabel.text = "Pressure: \(pressure) hPa"
        windLabel.text = "Wind: \(speed)"
        weatherImageView.image = uiManager.getImageById(icon.substring(to:icon.index(before: icon.endIndex)) + "d")
    }
}

extension detailViewController {
    class func viewController(_ weather:Weather) -> detailViewController {
        let viewController = self.viewController() as! detailViewController
        viewController.weather = weather
        return viewController
    }
}
