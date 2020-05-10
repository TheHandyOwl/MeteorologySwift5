//
//  FavoriteViewController.swift
//  MeteorologySwift5
//
//  Created by Carlos on 09/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var weatherFavoriteDict = [String : String]()

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weather: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var rain: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let getweatherFavoriteDict = UserDefaults.standard.value(forKey: "favoriteWeather") as? [String : String] {
            weatherFavoriteDict = getweatherFavoriteDict
            syncFavoriteWithView()
        }
        
    }
    
    func syncFavoriteWithView() {
        self.city.text = weatherFavoriteDict["city"]!
        self.weather.text = weatherFavoriteDict["weather"]!
        self.temperature.text = weatherFavoriteDict["temperature"]!
        self.clouds.text = weatherFavoriteDict["clouds"]!
        self.wind.text = weatherFavoriteDict["wind"]!
        self.humidity.text = weatherFavoriteDict["humidity"]!
        
        changeBackgroundImageWithTemperature(temperature: UserDefaults.standard.value(forKey: "backgroundImage") as! String)
    }
    
    func changeBackgroundImageWithTemperature(temperature: String) {
        self.backgroundImage.image = UIImage(named: temperature)
    }
    
}
