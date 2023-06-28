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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapForgetPassword))
        lblForgetPassword.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
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
