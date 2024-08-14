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
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchFilterContainer: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var topAnchorConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchFilterContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedBottomSuperViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentHeightConstraint: NSLayoutConstraint!
    
    private var categoryFilterDataSource = ["For You","Men", "Women", "Jacket", "Accessories"]

    
    lazy var blurredView: UIView = {
        return UIView()
    } ()
    
    ///Guide View Tap Count.
    private var guideTapCount: Int = 0
    ///Flag to show and hide the topFilterView
    private var isSegmentControlHidden: Bool = false {
        didSet {
            if isSegmentControlHidden {
                self.segmentHeightConstraint.constant = 0
                self.topViewContainerHeightConstraint.constant = 110
                self.topAnchorConstraint.constant = 0
                self.searchFilterContainerViewHeightConstraint.constant = 40
                self.filterCollectionView.isHidden = true
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
                
                self.topViewContainer.backgroundColor = UIColor(named: "onboardingViewControllerBackground")?.withAlphaComponent(0.0)
                self.topContainerBackgroundView.isHidden = false
                self.blurredView.frame = self.topContainerBackgroundView.bounds
            }
            else {
                self.segmentHeightConstraint.constant = 45
                if segmentedControl.selectedSegmentIndex == 0 {
                    self.topViewContainerHeightConstraint.constant = 180
                    self.searchFilterContainerViewHeightConstraint.constant = 80
                    self.filterCollectionView.isHidden = false
                    self.searchFilterContainer.isHidden = false
                    self.segmentedBottomSuperViewConstraint.priority = .defaultLow
                }
                else {
                    self.topViewContainerHeightConstraint.constant = 100
                    self.searchFilterContainer.isHidden = true
                    self.segmentedBottomSuperViewConstraint.priority = .required
                }
                self.topAnchorConstraint.constant = (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0) + 45
                
                self.topViewContainer.backgroundColor = UIColor(named: "onboardingViewControllerBackground")?.withAlphaComponent(1.0)
                self.topContainerBackgroundView.isHidden = true
                self.blurredView.frame = self.topContainerBackgroundView.bounds
            }
        }
    }
    private var pageViewController: StoreMainPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: String(describing: FilterCategoryCollectionViewCell.self), bundle: nil)
        filterCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: FilterCategoryCollectionViewCell.self))
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        filterCollectionView.collectionViewLayout = createCompositionalLayout()

                
        hideKeyboardWhenTappedAround()
        
        segmentedControl.addUnderlineForSelectedSegment()

        ///Embedding PageViewController to the VC.
        pageViewController = self.storyboard?.instantiateViewController(identifier: String(describing: StoreMainPageViewController.self)) { coder in
            StoreMainPageViewController(coder: coder, scrollDelegate: self, pagerDelegate: self)
        } as! StoreMainPageViewController
        
        addChild(pageViewController)

        self.embededViewContainer.addSubview(pageViewController.view)
        pageViewController.view.frame = embededViewContainer.bounds
        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        pageViewController.didMove(toParent: self)
        
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .light)
        blurredView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
        blurredView.frame = topContainerBackgroundView.bounds
        topContainerBackgroundView.addSubview(blurredView)
        
        self.guidView.isUserInteractionEnabled = true
        self.guidView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onGuidViewTap)))
        
        self.profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onProfileButtonTap))
        self.profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func onProfileButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ProfileDetailsViewController.self)) as? ProfileDetailsViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func onFilterButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: FIlterMainViewController.self)) as? FIlterMainViewController
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true)
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
        self.isSegmentControlHidden = false
        pageViewController.goToPage(index: self.segmentedControl.selectedSegmentIndex)
    }
    
    func onViewScrolled(didScrollUp: Bool) {
        self.isSegmentControlHidden = didScrollUp
    }
    
    func onPageChanged(selectedPage: Int) {
        self.segmentedControl.selectedSegmentIndex = selectedPage
        self.isSegmentControlHidden = false
        self.segmentChanged(self.segmentedControl)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.createFilterSection(sectionIndex: sectionIndex)
        }
        return layout
    }
    
    func createFilterSection(sectionIndex: Int) -> NSCollectionLayoutSection {
        
        var products: [NSCollectionLayoutItem] = []
        var verticalProducts: [NSCollectionLayoutItem] = []
        
        for _ in self.categoryFilterDataSource {
            let productItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.23), heightDimension: .fractionalHeight(1)))
            productItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
            products.append(productItem)
        }
        
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.68))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: products)
        //Section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

extension StoreLandingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryFilterDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FilterCategoryCollectionViewCell.self), for: indexPath) as! FilterCategoryCollectionViewCell
        cell.filterLabel.text = self.categoryFilterDataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
