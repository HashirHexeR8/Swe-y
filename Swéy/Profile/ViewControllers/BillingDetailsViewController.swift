//
//  BillingDetailsViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/18/23.
//

import UIKit

class BillingDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    @IBAction func onCompanyButtonTap(sender: Any!) {
        self.nameButton.isSelected = false
        self.companyButton.isSelected = true
    }
    
    @IBAction func onNameButtonTap(sender: Any!) {
        self.nameButton.isSelected = true
        self.companyButton.isSelected = false
    }
    
    @IBAction func onSaveChanges(sender: Any!) {
        dismiss(animated: true)
    }
    
    @IBAction func onBackTap(_ sender: Any) {
        dismiss(animated: true)
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
