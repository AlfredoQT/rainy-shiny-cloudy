//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/4/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather.downloadWeatherDetails {
            //Setup UI to downloaded data when completed download
            self.updateMainUI()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        return cell
    }
    
    func updateMainUI(){
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)°"
        locationLbl.text = currentWeather.cityName
        currentWeatherLbl.text = currentWeather.weatherType
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }

}

