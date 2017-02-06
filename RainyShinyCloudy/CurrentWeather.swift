//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/5/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        get {
            if _cityName == nil {
                _cityName = ""
            }
            return _cityName
        }
    }
    
    var date: String {
        get {
            //Get date formatted
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: Date())
            self._date = "Today, \(currentDate)"
            return _date
        }
    }
    
    var weatherType: String {
        get {
            if _weatherType == nil {
                _weatherType = ""
            }
            return _weatherType
        }
    }
    
    var currentTemp: Double {
        get {
            if _currentTemp == nil {
                _currentTemp = 0.0
            }
            return _currentTemp
        }
    }
    
    
    //Download JSON data
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            //Safe coding with optionals
            if let dict = result.value as? Dictionary<String,Any> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    //print(self._cityName)
                }
                if let weather = dict["weather"] as? [Dictionary<String,Any>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        //print(self._weatherType)
                    }
                }
                if let main = dict["main"] as? Dictionary<String,Any> {
                    if let temp = main["temp"] as? Double{
                        let kelvinToCelsius = temp - 273.15
                        self._currentTemp = Double(round(10*kelvinToCelsius)/10)
                        //print(self._currentTemp)
                    }
                }
            }
            //What to do when data has finished downloading
            //Like callback function
            completed()
        }
    }
}
