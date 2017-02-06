//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/4/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            //Setup UI to downloaded data when completed download of both current and forecast
            self.downloadForecastWeatherData {
                self.updateMainUI()
            }
        }
    }
    
    func downloadForecastWeatherData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: FORECAST_URL)
        Alamofire.request(forecastURL!).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    //Remove the first day since we already have it
                    self.forecasts.remove(at: 0)
                    //Reload table view data after loading forecasts
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else {
            return WeatherCell()
        }
    }
    
    func updateMainUI(){
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)°"
        locationLbl.text = currentWeather.cityName
        currentWeatherLbl.text = currentWeather.weatherType
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }

}

