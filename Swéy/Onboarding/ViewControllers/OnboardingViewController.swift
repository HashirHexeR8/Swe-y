//
//  OnboardingViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 3/29/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
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
        self.signUpButton.layer.shadowColor = UIColor.blue.cgColor
        self.signUpButton.layer.shadowOpacity = 0.5
        self.signUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.signUpButton.layer.shadowRadius = 4
        self.signUpButton.layer.masksToBounds = false
        
        let signupTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapSignup))
        lblSignInLabel.addGestureRecognizer(signupTapGesture)
    }
    
    @objc func onTapSignup(sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as? SignInViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func onGetStartedButtonTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SignupViewController.self)) as? SignupViewController
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
