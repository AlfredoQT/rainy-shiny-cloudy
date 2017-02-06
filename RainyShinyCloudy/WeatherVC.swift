//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/4/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Keeps track of our location
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var currentWeather: CurrentWeather!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        //Give best accurate location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //Request authorization only when using application
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
    }
    
    //Run locationAuthStatus before downloading data
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
    }
    
    func locationAuthStatus(){
        //Check if already authorized to use location of user
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //print(Location.sharedInstance.latitude,Location.sharedInstance.longitude)
            //We want to get our location before downloading data in case of getting a nil latitude or longitude
            currentWeather.downloadWeatherDetails {
                //Setup UI to downloaded data when completed download of both current and forecast
                self.downloadForecastWeatherData {
                    self.updateMainUI()
                }
            }
        }
        else{
            locationManager.requestWhenInUseAuthorization()
            //If not authorized, then authorize and recall function to set currentLocation
            locationAuthStatus()
        }
    }
    
    func downloadForecastWeatherData(completed: @escaping DownloadComplete){
        Alamofire.request(FORECAST_URL).responseJSON { response in
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

