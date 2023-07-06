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
    }
    
    @IBAction func onUserPhoneNumberTap(_ sender: Any) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
    }
    @objc func onTapForgetPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: ForgetPasswordViewController.self)) as? ForgetPasswordViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onNextButtonTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: PhoneNumberSignInViewController.self)) as? PhoneNumberSignInViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
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
