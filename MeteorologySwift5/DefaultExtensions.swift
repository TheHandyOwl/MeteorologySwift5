//
//  DefaultExtensions.swift
//  MeteorologySwift5
//
//  Created by Carlos on 03/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import UIKit

extension String {
    
    var urlEncoded : String {
        // Return valid URL with certain encoding type
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlUserAllowed)!
    }
    
    var trimmed : String {
        // No spaces at the beginning or at the end
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
