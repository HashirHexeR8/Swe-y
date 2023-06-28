//
//  CategoryFilterViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/4/23.
//

import UIKit

class CategoryFilterViewController: UIViewController {
    
    @IBOutlet weak var backgroundBlurView: UIView!
    @IBOutlet weak var seasonalItemSwitch: UISwitch!
    @IBOutlet weak var outfitsOnlySwitch: UISwitch!
    @IBOutlet weak var unisexSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        
        // Create a visual effect view with the blur effect
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        // Set the frame to cover the entire view
        blurView.frame = backgroundBlurView.bounds
        
        // Add the visual effect view as a subview
        backgroundBlurView.addSubview(blurView)
        
        seasonalItemSwitch.changeSwitchImage()
        outfitsOnlySwitch.changeSwitchImage()
        unisexSwitch.changeSwitchImage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackButtonTap(_ sender: Any!) {
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
