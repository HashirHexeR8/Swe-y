//
//  SignupViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 3/29/23.
//

import UIKit

class SignupViewController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var lblSignInLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var userSignupDTO = UserSignupRequestDTO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let range = ("Already have an account? Signin" as NSString).range(of: "Signin")
        
        let mutableAttributedString = NSMutableAttributedString.init(string: "Already have an account? Signin")
        
        let attributes:[NSAttributedString.Key : Any] = [.font : UIFont(name: "Poppins-Bold", size: 12.0)]
        mutableAttributedString.addAttributes(attributes, range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "onboardingLabelButtonColor"), range: range)
        lblSignInLabel.attributedText = mutableAttributedString
        
        self.signUpButton.clipsToBounds = false
        self.signUpButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.signUpButton.layer.shadowOpacity = 0.5
        self.signUpButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.signUpButton.layer.shadowRadius = 10
        self.signUpButton.layer.masksToBounds = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let signupTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapSignup))
        lblSignInLabel.addGestureRecognizer(signupTapGesture)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.dobTextField.delegate = self
    }
    
    func validateUserInfo() -> Bool {
        if let userEmail = self.emailTextField.text, userEmail.isEmpty {
            SweyAlertController.showAlert(title: "Error", message: "Please enter your email", vc: self)
            return false
        }
        if let userName = self.userNameTextField.text, userName.isEmpty {
            SweyAlertController.showAlert(title: "Error", message: "Please enter your username", vc: self)
            return false
        }
        if let dob = self.dobTextField.text, dob.isEmpty {
            SweyAlertController.showAlert(title: "Error", message: "Please enter your date of birth", vc: self)
            return false
        }
        if let password = self.passwordTextField.text, password.isEmpty {
            SweyAlertController.showAlert(title: "Error", message: "Please enter your password", vc: self)
            return false
        }
        return true
    }
    
    func signupUser() {
        if validateUserInfo() {
            userSignupDTO.email = emailTextField.text!
            userSignupDTO.password = passwordTextField.text!
            userSignupDTO.phoneNumber = "0123456789"
            userSignupDTO.username = userNameTextField.text!
            
            if self.checkBoxButton.isSelected {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PhoneNumberSignInViewController.self)) as? PhoneNumberSignInViewController
                vc?.userSignUpDTO = userSignupDTO
                vc?.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ProfilePictureViewController.self)) as? ProfilePictureViewController
                vc?.userSignupDTO = userSignupDTO
                vc?.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.dobTextField {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DOBPickerViewController.self)) as! DOBPickerViewController
            vc.onDatePicked = { date in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.dobTextField.text = formatter.string(from: date)
                self.userSignupDTO.dateOfBirth = Utilities.formatDateToDBFormat(date: date)
            }
            self.present(vc, animated: true)
            return false
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func onTapSignup(sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as? SignInViewController
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension SignupViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 160)
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
    
    @IBAction func onSignupButtonTap(_ sender: Any) {
        signupUser()
//        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: PhoneNumberViewController.self)) as? PhoneNumberViewController
//        vc?.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onUserPhoneNumberTap(_ sender: Any) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
    }
}
