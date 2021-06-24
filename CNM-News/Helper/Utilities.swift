//
//  Utilities.swift
//  CNM-News
//
//  Created by Chrismanto Manik on 6/24/21.
//

import Foundation
import UIKit
extension UIViewController{
    // MARK:  Toast Message
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 85 , y: self.view.frame.height/2, width: 170, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: "Avenir LT Pro 65 Medium", size: 14)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 1.2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
