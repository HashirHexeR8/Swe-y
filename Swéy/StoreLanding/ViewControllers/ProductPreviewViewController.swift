//
//  ProductPreviewViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/7/23.
//

import UIKit

class ProductPreviewViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!

    private var imageName: String = "s1p1"
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        
//        // Set the frame to cover the entire screen
//        view.frame = UIScreen.main.bounds
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.productImage.image = UIImage(named: self.imageName)
    }
    
    func setProductImage(imageName: String) {
        self.imageName = imageName
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
