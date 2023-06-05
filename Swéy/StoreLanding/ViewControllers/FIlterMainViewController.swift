//
//  FIlterMainViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/4/23.
//

import UIKit

class FIlterMainViewController: UIViewController {
    
    @IBOutlet weak var backgroundBlurView: UIView!
    @IBOutlet weak var mySizeSwitch: UISwitch!
    @IBOutlet weak var newItemSwitch: UISwitch!
    @IBOutlet weak var localItemsSwitch: UISwitch!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var sizeFilterView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .extraLight)
        
        // Create a visual effect view with the blur effect
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        // Set the frame to cover the entire view
        blurView.frame = backgroundBlurView.bounds
        
        // Add the visual effect view as a subview
        backgroundBlurView.addSubview(blurView)
        
        mySizeSwitch.changeSwitchImage()
        newItemSwitch.changeSwitchImage()
        localItemsSwitch.changeSwitchImage()
        
        let categoryTapGesture = UITapGestureRecognizer(target: self, action: #selector(onCategoryFilterTap))
        categoryView.addGestureRecognizer(categoryTapGesture)
        
        let sizeTapGesture = UITapGestureRecognizer(target: self, action: #selector(onSizeFilterTap))
        sizeFilterView.addGestureRecognizer(sizeTapGesture)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackButtonTap(_ sender: Any!) {
        dismiss(animated: true)
    }
    
    @objc func onCategoryFilterTap(_ sender: Any!) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: CategoryFilterViewController.self)) as? CategoryFilterViewController
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true)
    }
    
    @objc func onSizeFilterTap(_ sender: Any!) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: SizeTileFilterViewController.self)) as? SizeTileFilterViewController
        vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true)
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
