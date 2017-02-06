//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Alfredo Quintero Tlacuilo on 2/5/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import CoreLocation

class Location {
    //Accesible anywhere in the app
    static var sharedInstance = Location()
    
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
}
