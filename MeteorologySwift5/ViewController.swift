//
//  ViewController.swift
//  MeteorologySwift5
//
//  Created by Carlos on 03/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import UIKit

import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var getWeather : Connections!
    
    @IBOutlet weak var textCity: UITextField!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    @IBOutlet weak var labelRainyInformation: UILabel!
    
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelCloudy: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelRainy: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeather = Connections(delegate: self)
        
        setupUI()
        
        getLocation()
        
    }
    
    @IBAction func buttonGetWeatherByCity(_ sender: Any) {
        
        guard let text = textCity.text, !text.trimmed.isEmpty else {
            return
        }
        getWeather.requestWeatherByCity(text.urlEncoded)
        
    }
    
    @IBAction func buttonGetWeatherByGeolocation(_ sender: Any) {
        getLocation()
    }
    
}

extension ViewController {
    
    func setupUI() {
        
        textCity.text = ""
        textCity.placeholder = "Buscar por nombre de ciudad ..."
        textCity.delegate = self // To hide keyboard
        textCity.enablesReturnKeyAutomatically = true
        
        labelCity.text = ""
        labelDescription.text = ""
        
        labelTemperature.text = ""
        labelCloudy.text = ""
        labelWind.text = ""
        labelHumidity.text = ""
        labelRainy.text = ""
        
        labelRainyInformation.isHidden = true
        labelRainy.isHidden = true
        
        imageBackground.image = UIImage(named: "sun")
        
    }
    
    func changeBackgroudWithTemperature(temperature: Double) {
        let image : UIImage!
        switch temperature {
        case ...5:
            image = UIImage(named: "winter")
        case 5..<15:
            image = UIImage(named: "clouds")
        case 15...:
            image = UIImage(named: "sun")
        default:
            return
        }
        if let newImage = image {
            imageBackground.image = newImage
        }
    }
}

extension ViewController : CLLocationManagerDelegate {
    
    func getLocation() {
        
        locationManager.delegate = self
        
        // Permissions
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // Update frequency
        locationManager.distanceFilter = kCLDistanceFilterNone
        // Location accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The best power, the most resources
        //locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers // Low consumption, less resources
        // Starting
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
        let locValue : CLLocationCoordinate2D = manager.location!.coordinate
        
        let latitude : Double = locValue.latitude
        let longitude : Double = locValue.longitude
        
        print("Latitude: \(latitude) and longitude: \(longitude)")

        getWeather.requestWeatherByLocation(latitude: latitude, longitude: longitude)
        
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        
        let alertView = UIAlertController(title: "Error", message: "GPS does not work properly", preferredStyle: .alert)
        
        let button = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertView.addAction(button)
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension ViewController : getWeatherDelegate {
    func getWeatherDidFinish(weatherInfo: Weather) {
        print("getWeatherDidFinish")
        
        // Main thread
        DispatchQueue.main.async {
            self.labelCity.text = weatherInfo.city
            self.labelDescription.text = weatherInfo.weatherDescription
            
            self.labelTemperature.text = "\(Int(round(weatherInfo.tempCelsius)))"
            self.labelCloudy.text = "\(weatherInfo.clouds)%"
            self.labelWind.text = "\(weatherInfo.windSpeed) m/s"
            self.labelHumidity.text = "\(weatherInfo.humidity)%"
            
            if let rainy3h = weatherInfo.rain3Hours {
                self.labelRainyInformation.isHidden = false
                self.labelRainy.isHidden = false
                self.labelRainy.text = "\(rainy3h) mm"
            } else {
                self.labelRainyInformation.isHidden = true
                self.labelRainy.isHidden = true
            }
            
            //self.imageBackground.image
            self.changeBackgroudWithTemperature(temperature: weatherInfo.tempCelsius)
            
            self.locationManager.stopUpdatingLocation()
            
        }
        
    }
    
    func getWeatherDidFailWithError(error: NSError) {
        print("getWeatherDidFailWithError")
        
        // Main thread
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "Error", message: "Error: \(error.description)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(self, animated: true, completion: nil)
        }
        
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textCity.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textCity.text = "" // Clear button should be enabled
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
