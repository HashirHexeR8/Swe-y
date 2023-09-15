//
//  CartViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/30/23.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var shareCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        let nib = UINib(nibName: String(describing: CartTableViewCell.self), bundle: nil)
        cartTableView.register(nib, forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        
        updateCollectionViewHeight()
        
        let cornerRadius: CGFloat = 25.0
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.shareCartButton.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        self.shareCartButton.layer.mask = maskLayer
        
        self.checkoutButton.clipsToBounds = false
        self.checkoutButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.checkoutButton.layer.shadowOpacity = 0.5
        self.checkoutButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.checkoutButton.layer.shadowRadius = 10
        self.checkoutButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.checkoutButton.layer.masksToBounds = false
        
    }
    
    @IBAction func onBackButtonTap() {
        dismiss(animated: true)
    }
    
    @IBAction func onCheckoutButtonTap() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PaymentDetailsViewController.self)) as? PaymentDetailsViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func onShareButtonTap () {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ChatViewController.self)) as? ChatViewController
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true)
    }
    
    func updateCollectionViewHeight() {
        self.cartTableView.layoutIfNeeded()
        self.cartTableView.constraints.forEach { constraint in
            if constraint.identifier == "tableViewHeightConstraint" {
                constraint.constant = self.cartTableView.contentSize.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartTableViewCell.self)) as! CartTableViewCell
        if indexPath.row == 0 {
            cell.productImage.image = UIImage(named: "cartItem1")
        }
        else if indexPath.row == 1 {
            cell.productImage.image = UIImage(named: "cartItem2")
        }
        else if indexPath.row == 2 {
            cell.productImage.image = UIImage(named: "cartItem3")
        }
        return cell
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
