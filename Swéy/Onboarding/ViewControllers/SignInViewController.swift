//
//  SignInViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var lblForgetPassword: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var lblSignUpButton: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapForgetPassword))
        lblForgetPassword.addGestureRecognizer(tapGesture)
        
        let range = ("Don’t Have an account? Signup" as NSString).range(of: "Signup")

        let mutableAttributedString = NSMutableAttributedString.init(string: "Don’t Have an account? Signup")
        
        let attributes:[NSAttributedString.Key : Any] = [.font : UIFont(name: "Poppins-Bold", size: 12.0)]
        mutableAttributedString.addAttributes(attributes, range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "onboardingLabelButtonColor"), range: range)
        lblSignUpButton.attributedText = mutableAttributedString
        
        self.signInButton.clipsToBounds = false
        self.signInButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.signInButton.layer.shadowOpacity = 0.5
        self.signInButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.signInButton.layer.shadowRadius = 10
        self.signInButton.layer.masksToBounds = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let signupTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapSignup))
        lblSignUpButton.addGestureRecognizer(signupTapGesture)
    }
    
    func validateSignIn() -> Bool {
        if let email = emailField.text, email.isEmpty {
            SweyAlertController.showAlert(title: "Error", message: "Please enter a valid email.", vc: self)
            return false
        }
        if let password = passwordField.text, password.isEmpty {
            SweyAlertController.showAlert(title: "Error", message: "Please enter a valid password.", vc: self)
            return false
        }
        
        return true
    }
}

extension SignInViewController {
    @objc func onTapSignup(sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SignupViewController.self)) as? SignupViewController
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
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
    
    @IBAction func onUserPhoneNumberTap(_ sender: Any) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
    }
    
    @objc func onTapForgetPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: ForgetPasswordViewController.self)) as? ForgetPasswordViewController
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onNextButtonTap(_ sender: Any) {
        if validateSignIn() {
            SweyAlertController.showLoadingAlert(message: "Signing in...", vc: self)
            let loginDTO = LoginRequestDTO(email: emailField.text!, password: passwordField.text!)
            Task {
                do {
                    try await AuthService.sharedInstance.loginUser(loginDTO: loginDTO)
                    DispatchQueue.main.async {
                        SweyAlertController.hideLoadingAlert()
                        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "StoreLandingNavigationController" ) as? UINavigationController
                        vc?.modalPresentationStyle = .fullScreen
                        self.present(vc!, animated: true)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        SweyAlertController.hideLoadingAlert()
                        SweyAlertController.showAlert(title: "Error", message: error.localizedDescription, vc: self)
                    }
                }
            }
        }
    }
    
}
