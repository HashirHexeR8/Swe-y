//
//  SendPaymentViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/17/23.
//

import UIKit

class SendPaymentViewController: UIViewController {

    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var conversionButton: UIButton!
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
    } ()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conversionButton.clipsToBounds = false
        self.conversionButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.conversionButton.layer.shadowOpacity = 0.5
        self.conversionButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.conversionButton.layer.shadowRadius = 10
        self.conversionButton.layer.masksToBounds = false
        
        blurredView.frame = self.mainBackgroundView.bounds
        self.mainBackgroundView.addSubview(blurredView)
        
        let onBlurViewTap = UITapGestureRecognizer(target: self, action: #selector(onBlueViewTap))
        mainBackgroundView.addGestureRecognizer(onBlurViewTap)
        mainBackgroundView.isUserInteractionEnabled = true
    }
    
    @IBAction func onCloseButtonTap(_ sender: Any!) {
        dismiss(animated: true)
    }
    
    @objc func onBlueViewTap(_ sender: Any!) {
        dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
