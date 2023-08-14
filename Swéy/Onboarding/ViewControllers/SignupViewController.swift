//
//  SignupViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 3/29/23.
//

import UIKit

class SignupViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var lblSignInLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
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
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func onTapSignup(sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as? SignInViewController
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
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
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: PhoneNumberViewController.self)) as? PhoneNumberViewController
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onUserPhoneNumberTap(_ sender: Any) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
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
