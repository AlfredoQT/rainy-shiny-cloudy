//
//  ForecastCell.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/5/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var dayOfWeekLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    
    func configureCell(forecast: Forecast){
        dayOfWeekLbl.text = forecast.date
        weatherTypeLbl.text = forecast.weatherType
        highTempLbl.text = "\(forecast.highTemp)°"
        lowTempLbl.text = "\(forecast.lowTemp)°"
        thumbImg.image = UIImage(named: "\(forecast.weatherType) Mini")
    }
    
}
