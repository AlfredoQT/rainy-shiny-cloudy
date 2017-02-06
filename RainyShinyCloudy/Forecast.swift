//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/5/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    var date: String {
        get {
            if _date == nil {
                _date = ""
            }
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
    
    var highTemp: Double {
        get {
            if _highTemp == nil {
                _highTemp = 0.0
            }
            return _highTemp
        }
    }
    
    var lowTemp: Double {
        get {
            if _lowTemp == nil {
                _lowTemp = 0.0
            }
            return _lowTemp
        }
    }
    
    init(weatherDict: Dictionary<String, Any>) {
        if let dt = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: dt)
            self._date = unixConvertedDate.dayOfWeek()
            //print(self._date)
        }
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            if let max = temp["max"] as? Double {
                self._highTemp = Double(round(10*(max-273.15))/10)
                //print(self._highTemp)
            }
            if let min = temp["min"] as? Double {
                self._lowTemp = Double(round(10*(min-273.15))/10)
                //print(self._lowTemp)
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                //print(self._weatherType)
            }
        }
    }
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
