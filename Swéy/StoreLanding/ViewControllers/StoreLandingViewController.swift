//
//  StoreLandingViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/14/23.
//

import UIKit

class StoreLandingViewController: UIViewController, ScrollDirectionDelegate, PageChangeDelegate {
    
    @IBOutlet weak var embededViewContainer: UIView!
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var topContainerBackgroundView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var guidView: UIView!
    @IBOutlet weak var guidTile1: UIView!
    @IBOutlet weak var guidTile2: UIView!
    @IBOutlet weak var guidTile3: UIView!
    @IBOutlet weak var topAnchorConstraint: NSLayoutConstraint!
    
    lazy var blurredView: UIView = {
        return UIView()
    } ()
    
    ///Guide View Tap Count.
    private var guideTapCount: Int = 0
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
                topAnchorConstraint.constant = 0
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
                topAnchorConstraint.constant = (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) + 45
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
        var vc: UIViewController = self.storyboard?.instantiateViewController(identifier: String(describing: StoreMainPageViewController.self)) { coder in
            StoreMainPageViewController(coder: coder, scrollDelegate: self, pagerDelegate: self)
        } as! StoreMainPageViewController
        
        addChild(vc)

        self.embededViewContainer.addSubview(vc.view)
        vc.view.frame = embededViewContainer.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        vc.didMove(toParent: self)
        
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .light)
        blurredView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
        blurredView.frame = topContainerBackgroundView.bounds
        topContainerBackgroundView.addSubview(blurredView)
        
        self.guidView.isUserInteractionEnabled = true
        self.guidView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onGuidViewTap)))
    }
    
    @objc func onGuidViewTap(_ sender: Any) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            
            switch self.guideTapCount {
            case 0:
                self.guidTile1.isHidden = true
                self.guidTile2.isHidden = false
            case 1:
                self.guidTile2.isHidden = true
                self.guidTile3.isHidden = false
            case 2:
                self.guidTile3.isHidden = true
                self.guidView.isHidden = true
            default:
                self.guidView.isHidden = true
            }
        })
        self.guideTapCount += 1
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.segmentedControl.changeBackgroundForAppearanceSwitch()
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        self.segmentedControl.changeUnderlinePosition()
    }
    
    func onViewScrolled(didScrollUp: Bool) {
        self.isSegmentControlHidden = didScrollUp
    }
    
    func onPageChanged(selectedPage: Int) {
        self.segmentedControl.selectedSegmentIndex = selectedPage
        self.segmentChanged(self.segmentedControl)
    }
}
