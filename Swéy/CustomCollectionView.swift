//
//  CustomCollectionView.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/3/23.
//

import UIKit

class CustomCollectionView: UICollectionView, UIGestureRecognizerDelegate {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let gesture = UIGestureRecognizer()
        gesture.delegate = self // Set Gesture delegate so that shouldRecognizeSimultaneouslyWithGestureRecognizer can be set to true on initialzing the UICollectionView
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
