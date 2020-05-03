//
//  ViewController.swift
//  MeteorologySwift5
//
//  Created by Carlos on 03/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonGetWeatherByCity(_ sender: Any) {
    }
    
    @IBAction func buttonGetWeatherByGeolocation(_ sender: Any) {
    }
    
}

