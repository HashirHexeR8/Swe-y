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
    @IBOutlet weak var pannableView: UIView!
    
    private var originalViewPosition = CGPoint(x: 0.0, y: 0.0)
    
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
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurredView.frame = self.backgroundBlurView.bounds
        
        self.backgroundBlurView.addSubview(blurredView)
                
        mySizeSwitch.changeSwitchImage()
        newItemSwitch.changeSwitchImage()
        localItemsSwitch.changeSwitchImage()
        
        let categoryTapGesture = UITapGestureRecognizer(target: self, action: #selector(onCategoryFilterTap))
        categoryView.addGestureRecognizer(categoryTapGesture)
        
        let sizeTapGesture = UITapGestureRecognizer(target: self, action: #selector(onSizeFilterTap))
        sizeFilterView.addGestureRecognizer(sizeTapGesture)
        
        let onBlurViewTap = UITapGestureRecognizer(target: self, action: #selector(onBlueViewTap))
        backgroundBlurView.addGestureRecognizer(onBlurViewTap)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:)))
        self.view.addGestureRecognizer(panGesture)
        
        self.originalViewPosition = self.pannableView.frame.origin

        // Do any additional setup after loading the view.
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view?.window)
        let direction = sender.velocity(in: view?.window)
        var initialTouchPoint = CGPoint.zero

        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y > initialTouchPoint.y && touchPoint.y > self.pannableView.frame.origin.y {
                pannableView.frame.origin.y = touchPoint.y - initialTouchPoint.y
            }
        case .ended, .cancelled:
            if touchPoint.y - initialTouchPoint.y > 600 {
                dismiss(animated: true, completion: nil)
            }
            else if direction.y > 0.0 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.pannableView.frame = CGRect(x: self.originalViewPosition.x, y: self.originalViewPosition.y, width: self.pannableView.frame.size.width, height: self.pannableView.frame.size.height)
                })
            }
        default:
            break
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any!) {
        dismiss(animated: true)
    }
    
    @objc func onBlueViewTap(_ sender: Any!) {
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
