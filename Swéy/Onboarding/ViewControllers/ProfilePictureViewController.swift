//
//  ProfilePictureViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit

class ProfilePictureViewController: UIViewController {

    @IBOutlet weak var chooseImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.chooseImageButton.clipsToBounds = false
        self.chooseImageButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.chooseImageButton.layer.shadowOpacity = 0.5
        self.chooseImageButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.chooseImageButton.layer.shadowRadius = 10
        self.chooseImageButton.layer.masksToBounds = false
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onImageButtonTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as? SignInViewController
        vc?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
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
