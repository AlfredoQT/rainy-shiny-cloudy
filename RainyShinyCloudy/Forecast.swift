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
    
    
}
