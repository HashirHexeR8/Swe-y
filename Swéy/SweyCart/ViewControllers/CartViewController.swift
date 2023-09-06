//
//  CartViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/30/23.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        let nib = UINib(nibName: String(describing: CartTableViewCell.self), bundle: nil)
        cartTableView.register(nib, forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        
        updateCollectionViewHeight()
        
    }
    
    @IBAction func onBackButtonTap() {
        dismiss(animated: true)
    }
    
    func updateCollectionViewHeight() {
        self.cartTableView.layoutIfNeeded()
        self.cartTableView.constraints.forEach { constraint in
            if constraint.identifier == "tableViewHeightConstraint" {
                constraint.constant = 1000.0
                self.scrollView.contentSize.height = self.scrollView.contentSize.height + constraint.constant
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartTableViewCell.self)) as! CartTableViewCell
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
