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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var prefferedCourierTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    func validateBillingFields() -> Bool {
        if nameTextField.text?.isEmpty == true {
            SweyAlertController.showAlert(title: "Error", message: "Please enter a name", vc: self)
            return false
        }
        if countryTextField.text?.isEmpty == true {
            SweyAlertController.showAlert(title: "Error", message: "Country Field cannot be empty", vc: self)
            return false
        }
        if cityTextField.text?.isEmpty == true {
            SweyAlertController.showAlert(title: "Error", message: "City Field cannot be empty", vc: self)
            return false
        }
        if addressTextField.text?.isEmpty == true {
            SweyAlertController.showAlert(title: "Error", message: "Address Field cannot be empty", vc: self)
            return false
        }
        if zipCodeTextField.text?.isEmpty == true {
            SweyAlertController.showAlert(title: "Error", message: "Zip Code Field cannot be empty", vc: self)
            return false
        }
        if stateTextField.text?.isEmpty == true {
            SweyAlertController.showAlert(title: "Error", message: "State Field cannot be empty", vc: self)
            return false
        }
        if prefferedCourierTextField.text?.isEmpty == true {
            SweyAlertController.showAlert(title: "Error", message: "Preffered Courier Field cannot be empty", vc: self)
            return false
        }
        return true
    }
    
    func persistBillingDetails() {
        if (validateBillingFields()) {
            var requestDTO = PersistBillingDetailsRequestDTO()
            requestDTO.propertyType = nameButton.isSelected == true ? 1 : 2
            requestDTO.address = addressTextField.text ?? ""
            requestDTO.city = cityTextField.text ?? ""
            requestDTO.country = countryTextField.text ?? ""
            requestDTO.zip = zipCodeTextField.text ?? ""
            SweyAlertController.showLoadingAlert(message: "Saving Details, Please Wait", vc: self)
            Task {
                do {
                    try await ProfileService.sharedInstance.persistUserBillingDetails(params: requestDTO)
                    DispatchQueue.main.async {
                        SweyAlertController.hideLoadingAlert()
                        SweyAlertController.showAlert(title: "Success", message: "Billing Details updated.", vc: self)
                    }
                }
                catch {
                    SweyAlertController.showAlert(title: "Error", message: error.localizedDescription, vc: self)
                }
            }
        }
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
        persistBillingDetails()
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
