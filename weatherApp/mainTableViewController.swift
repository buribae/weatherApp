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
        case other
        case end
    }
    
    func screenName() -> String { return "main" }
    
    var weather: Weather?
    var otherWeathers: [Weather] = []
    
    // ________________________________________
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        // Initialize Nib
        self.tableView?.register(UINib.init(nibName:mainTodayTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: mainTodayTableViewCell.reuseIdentifier())
        self.tableView?.register(UINib.init(nibName:mainOtherTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: mainOtherTableViewCell.reuseIdentifier())
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
        case Section.other.rawValue:
            return self.otherWeathers.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.today.rawValue:
            return mainTodayTableViewCell.height
        case Section.other.rawValue:
            return mainOtherTableViewCell.height
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
            
        case Section.other.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: mainOtherTableViewCell.reuseIdentifier(), for: indexPath) as! mainOtherTableViewCell
            cell.weather = self.otherWeathers[indexPath.row]
            return cell
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case Section.today.rawValue:
            break
        case Section.other.rawValue:
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
        APIClient.sharedInstance.request(URL(string:"http://api.openweathermap.org/data/2.5/forecast/daily")!, method: HTTPMethod.get, parameters: ["units":"imperial","q":"Atlanta,ga","cnt":"5","APPID":APIClient.sharedInstance.apiKey],
            successHandler: {(json) -> Void in
                guard let list = json["list"] else {return}
                self.otherWeathers = self.weatherFromArray(list as! Array<[String : Any]>)
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
                                            
            }, failHandler:{(response) -> Void in
                print(response.statusCode)
        })
    }
    
    open func weatherFromArray(_ jsonArray: Array<[String:Any]>) -> [Weather] {
        var objects = [] as [Weather]
        for json in jsonArray {
            if let object = Weather.init(json, isOther:true) {
                objects.append(object)
            }
        }
        return objects
    }
}
