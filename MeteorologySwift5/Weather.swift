//
//  Weather.swift
//  MeteorologySwift5
//
//  Created by Carlos on 03/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import Foundation

struct Weather {
    
    let city : String
    let country : String
    let latitude : Double
    let longitude : Double
    let weatherDescription : String
    let temperature : Double
    let humidity : Int
    let pressure : Double
    let clouds : Int
    let windSpeed : Double
    let rain3Hours : Double
    
    init(datosTiempo : [ String : AnyObject ]) {
        self.city = datosTiempo["name"] as! String
        
        let sysDict = datosTiempo["sys"] as! [String:AnyObject]
        self.country = sysDict["country"] as! String
        
        let coordDict = datosTiempo["coord"] as! [String:AnyObject]
        self.latitude = coordDict["lat"] as! Double
        self.longitude = coordDict["lon"] as! Double
        
        let weatherDict = datosTiempo["weather"] as! [String:AnyObject]
        self.weatherDescription = weatherDict["description"] as! String
        
        let mainDict = datosTiempo["main"] as! [String:AnyObject]
        self.temperature = mainDict["temp"] as! Double
        self.humidity = mainDict["humidity"] as! Int
        self.pressure = mainDict["pressure"] as! Double

        //self.clouds = datosTiempo["clouds"]!["all"] as! Int
        let cloudsDict = datosTiempo["clouds"] as! [String:AnyObject]
        self.clouds = cloudsDict["all"] as! Int
        
        let windDict = datosTiempo["wind"] as! [String:AnyObject]
        self.windSpeed = windDict["speed"] as! Double
        
        //self.rain3Hours = datosTiempo["rain"]!["3h"] as! Double
        let rainDict = datosTiempo["rain"] as! [String:AnyObject]
        self.rain3Hours = rainDict["3h"] as! Double
    }
    
}

extension Weather {
    
    // To Celsuis
    var tempCelsius : Double {
        get {
            return temperature - 273.15
        }
    }
    // To Farenheit
    var tempFarenheits : Double {
        get {
            return (temperature - 273.15) * 1.8 + 32
        }
    }
    
}
