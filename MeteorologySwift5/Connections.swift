//
//  Connections.swift
//  MeteorologySwift5
//
//  Created by Carlos on 03/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import UIKit

class Connections {

    // Example -> "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=myAPIKey"
    fileprivate let baseURL : String = "http://api.openweathermap.org/data/2.5/weather"
    fileprivate let openWeatherMapKey : String = "0f8c1e1b87cc8cf521195b272bc9a22c"
    
    // Request by city
    func requestWeatherByCity(_ city: String) {
        
        let weatherRequestURL = URL(string: "\(baseURL)?q=\(city)&APPID=\(openWeatherMapKey)&lang=es")!
        getWeather(weatherRequestURL)
        
    }
    
    // Request by place
    func requestWeatherByLocation(latitude: Double, longitude: Double) {
        
        let weatherRequestURL = URL(string: "\(baseURL)?APPID=\(openWeatherMapKey)&lat=\(latitude)&lon=\(longitude)&lang=es")!
        getWeather(weatherRequestURL)
        
    }
    
}

extension Connections {
    
    func getWeather(_ weatherRequestURL: URL) {
        
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 5 // Seconds
        
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest(url: weatherRequestURL)
        
        let task = session.dataTask(with: urlRequest as URLRequest) { (data, resonse, error) -> Void in
            
            let httpResponse = resonse as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
                    
                    let weather = Weather(datosTiempo: parsedData as [String : AnyObject])
                    print("El tiempo tiene: \(weather)")
                } catch let jsonError as NSError {
                    print("Error: \(jsonError)")
                }
                
            }
            
        }
        
        task.resume()
        
    }

}
