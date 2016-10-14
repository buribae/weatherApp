//
//  mainViewController.swift
//  weatherApp
//
//  Created by StephenJang on 10/13/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import UIKit

class mainTableViewController: UITableViewController {
    
    enum Section: Int {
        case today = 0
        case week
        case end
    }
    
    func screenName() -> String { return "main" }
    
    var weather: Weather?
    
    // ________________________________________
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        // Initialize Nib
        self.tableView?.register(UINib.init(nibName:mainTodayTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: mainTodayTableViewCell.reuseIdentifier())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ________________________________________
    // MARK: TableView Delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.end.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.today.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.today.rawValue:
            return mainTodayTableViewCell.height
        case Section.week.rawValue:
            return 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.today.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: mainTodayTableViewCell.reuseIdentifier(), for: indexPath) as! mainTodayTableViewCell
            
            cell.weather = self.weather
            
            return cell
        case Section.week.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: mainTodayTableViewCell.reuseIdentifier(), for: indexPath) as! mainTodayTableViewCell
            return cell
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case Section.today.rawValue:
            break
        case Section.week.rawValue:
            break
        default:
            break
        }
    }
    
}

// API Request Related Extension
extension mainTableViewController {
    func fetchData(){
        APIClient.sharedInstance.request(URL(string:"http://api.openweathermap.org/data/2.5/weather")!, method: HTTPMethod.get, parameters: ["units":"imperial","q":"Atlanta,ga","APPID":APIClient.sharedInstance.apiKey],
            successHandler: {(json) -> Void in
                self.weather = Weather.init(json)
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
                
            }, failHandler:{(response) -> Void in
                print(response.statusCode)
            })
    }
}
