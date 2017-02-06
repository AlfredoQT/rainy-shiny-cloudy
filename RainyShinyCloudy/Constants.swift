//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/5/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "aaa5088c9cbbefed31ffd7d147135a0e"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=19&lon=-99&cnt=10&mode=json&appid=aaa5088c9cbbefed31ffd7d147135a0e"


//Callback function for when the data download is done
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)19\(LONGITUDE)-99\(APP_ID)\(API_KEY)"
