//
//  Connections.swift
//  MeteorologySwift5
//
//  Created by Carlos on 03/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import UIKit

protocol getWeatherDelegate {
    
    func getWeatherDidFinish(weatherInfo : Weather)
    func getWeatherDidFailWithError(error : NSError)
    
}

class Connections {
    
    // Example -> "https://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=myAPIKey"
    fileprivate let baseURL : String = "https://api.openweathermap.org/data/2.5/weather"
    #warning("WARNING: PUT YOUR OWN APIKEY: api.openweathermap.org")
    fileprivate let openWeatherMapKey : String = "1234567890"
    
    fileprivate var delegate : getWeatherDelegate
    
    init(delegate: getWeatherDelegate) {
        self.delegate = delegate
        if openWeatherMapKey == "1234567890" {
            print("""




                ==============================
                ==
                == Do you have your own APIkey?
                ==
                ==============================





                """)
        }
    }
    
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
        
        let task = session.dataTask(with: urlRequest as URLRequest) { (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
                    
                    let weather = Weather(datosTiempo: parsedData as [String : AnyObject])
                    
                    self.delegate.getWeatherDidFinish(weatherInfo: weather)
                    print("El tiempo tiene: \(weather)")
                    
                } catch let jsonError as NSError {
                    
                    self.delegate.getWeatherDidFailWithError(error: jsonError)
                    print("Error: \(jsonError)")
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
}
