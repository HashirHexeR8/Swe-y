//
//  SweyAlertController.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 21/10/2024.
//

import Foundation
import UIKit

struct SweyAlertController {
    
    static var loadingAlert: UIAlertController?
    
    // Function to show loading alert
    static func showLoadingAlert(message: String, vc: UIViewController) {
        loadingAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.isUserInteractionEnabled = false
        loadingIndicator.startAnimating()

        loadingAlert?.view.addSubview(loadingIndicator)
        loadingAlert?.view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: loadingAlert!.view.centerXAnchor).isActive = true
        loadingIndicator.bottomAnchor.constraint(equalTo: loadingAlert!.view.bottomAnchor, constant: -20).isActive = true
        
        if let alert = loadingAlert {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // Function to hide loading alert
    static func hideLoadingAlert() {
        loadingAlert?.dismiss(animated: true, completion: nil)
    }
    
    static func showAlert(title: String?, message: String?, vc: UIViewController) {
        loadingAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        loadingAlert?.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(loadingAlert!, animated: true)
    }
}
