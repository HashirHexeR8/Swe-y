//
//  ForgetPasswordViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 130)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSendCodeButtonTap(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        if email.isEmpty || !email.isValidEmail() {
            SweyAlertController.showAlert(title: "Error", message: "Please enter a valid email address.", vc: self)
            return
        }
        SweyAlertController.showLoadingAlert(message: "Requesting OTP...", vc: self)
        Task {
            do {
                let response = try await AuthService.sharedInstance.requestPasswordResetOTP(email: email)
                SweyAlertController.hideLoadingAlert()
                let vc = storyboard?.instantiateViewController(identifier: String(describing: RecoveryOTPViewController.self)) { coder in
                    RecoveryOTPViewController(coder: coder, otpToken: response?.token ?? "", userEmail: email)
                }
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: true)
            }
            catch {
                SweyAlertController.hideLoadingAlert()
                SweyAlertController.showAlert(title: "Error", message: error.localizedDescription, vc: self)
            }
        }
        
        
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
