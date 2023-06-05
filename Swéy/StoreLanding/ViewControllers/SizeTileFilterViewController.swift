//
//  SizeTileFilterViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/4/23.
//

import UIKit

class SizeTileFilterViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundBlurView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
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
        
        let nib = UINib(nibName: String(describing: SizeTileFilterCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: SizeTileFilterCollectionViewCell.self))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: createNormalProductSection(sectionIndex: 0))
        
        segmentedControl.addUnderlineForSelectedSegment()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackButtonTap(_ sender: Any!) {
        dismiss(animated: true)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        self.segmentedControl.changeUnderlinePosition()
    }
    
    func createNormalProductSection(sectionIndex: Int) -> NSCollectionLayoutSection {
        
        
        
        let sizeItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.20), heightDimension: .fractionalHeight(1)))
        sizeItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: sizeItem, count: 5)
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        return section
    }

}

extension SizeTileFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SizeTileFilterCollectionViewCell.self), for: indexPath) as! SizeTileFilterCollectionViewCell
        return cell
    }

}
