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
    
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelCloudy: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelRainy: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        getLocation()
        
    }

    @IBAction func buttonGetWeatherByCity(_ sender: Any) {
        
        guard let text = textCity.text, !text.trimmed.isEmpty else {
            return
        }
        getWeather = Connections()
        getWeather.requestWeatherByCity(text.urlEncoded)

    }
    
    @IBAction func buttonGetWeatherByGeolocation(_ sender: Any) {
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
        labelRainy.text = ""
        labelHumidity.text = ""

        //imageBackground.image
        
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
        
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        
        let alertView = UIAlertController(title: "Error", message: "GPS does not work properly", preferredStyle: .alert)
        
        let button = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertView.addAction(button)
        dismiss(animated: true, completion: nil)

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
