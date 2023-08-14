//
//  StoreLandingViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/14/23.
//

import UIKit

class StoreLandingViewController: UIViewController {
    
    @IBOutlet weak var embededViewContainer: UIView!
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var topContainerBackgroundView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var blurredView: UIView = {
        return UIView()
    } ()
    
    ///Flag to show and hide the topFilterView
    private var isSegmentControlHidden: Bool = false {
        didSet {
            if isSegmentControlHidden {
                for constraint in segmentedControl.constraints {
                    if constraint.identifier == "segmentHeightConstraint" {
                        constraint.constant = 0
                    }
                }
                for constraint in topViewContainer.constraints {
                    if constraint.identifier == "viewHeightConstraint" {
                        constraint.constant = 55
                    }
                }
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
                
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
                self.topViewContainer.backgroundColor = UIColor(named: "onboardingViewControllerBackground")?.withAlphaComponent(0.0)
                self.topContainerBackgroundView.isHidden = false
                self.blurredView.frame = self.topContainerBackgroundView.bounds
            }
            else {
                //blurView?.effect = .none
                for constraint in segmentedControl.constraints {
                    if constraint.identifier == "segmentHeightConstraint" {
                        constraint.constant = 45
                    }
                }
                for constraint in topViewContainer.constraints {
                    if constraint.identifier == "viewHeightConstraint" {
                        constraint.constant = 100
                    }
                }
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
                
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
                self.topViewContainer.backgroundColor = UIColor(named: "onboardingViewControllerBackground")?.withAlphaComponent(1.0)
                self.topContainerBackgroundView.isHidden = true
                self.blurredView.frame = self.topContainerBackgroundView.bounds
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        segmentedControl.addUnderlineForSelectedSegment()

        ///Embedding PageViewController to the VC.
        var vc: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: StoreMainPageViewController.self)) as! StoreMainPageViewController
        
        addChild(vc)

        self.embededViewContainer.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        vc.didMove(toParent: self)
        
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .light)
        // Create a visual effect view with the blur effect
        blurredView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
        // Set the frame to cover the entire view
        blurredView.frame = topContainerBackgroundView.bounds
        // Add the visual effect view as a subview
        topContainerBackgroundView.addSubview(blurredView)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        self.segmentedControl.changeUnderlinePosition()
    }

}
