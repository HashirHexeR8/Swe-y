//
//  SettingsViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/14/23.
//

import UIKit

class ProfileDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var settingsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        
        let settingsCellNib = UINib(nibName: String(describing: SettingsTableViewCell.self), bundle: nil)
        let settingsAccountActionCellNib = UINib(nibName: String(describing: SettingsAccountActionButtonTableViewCell.self), bundle: nil)
        let settingsAppVersionCellNib = UINib(nibName: String(describing: SettingsAppVersionTableViewCell.self), bundle: nil)
        
        self.settingsTableView.register(settingsCellNib, forCellReuseIdentifier: String(describing: SettingsTableViewCell.self))
        self.settingsTableView.register(settingsAccountActionCellNib, forCellReuseIdentifier: String(describing: SettingsAccountActionButtonTableViewCell.self))
        self.settingsTableView.register(settingsAppVersionCellNib, forCellReuseIdentifier: String(describing: SettingsAppVersionTableViewCell.self))
    }
    
    @IBAction func onTapBackButton(_ sender: Any!) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch ProfileDetailsCellType(rawValue: indexPath.row) {
            
        case .profileCell, .privacyAndSafetyCell, .contentAndPreferencesCell, .settingsCell, .discountsCell, .supportCell, .darkModeCell:
            let cellType = ProfileDetailsCellType(rawValue: indexPath.row)
            let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self)) as! SettingsTableViewCell
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: cellType == .darkModeCell, isProfileImage: false)
            }
            return cell
        case .switchAccountButtonCell, .addAccountButtonCell, .logoutButtonCell:
            let cellType = ProfileDetailsCellType(rawValue: indexPath.row)
            let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: String(describing: SettingsAccountActionButtonTableViewCell.self)) as! SettingsAccountActionButtonTableViewCell
            if let cellType = cellType {
                cell.setupCell(buttonText: cellType.getCellLabelText(), isLogoutButton: cellType == .logoutButtonCell)
            }
            return cell
        default:
            let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: String(describing: SettingsAppVersionTableViewCell.self)) as! SettingsAppVersionTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ProfileDetailsCellType.profileCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ProfileViewController.self)) as? ProfileViewController
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
        else if indexPath.row == ProfileDetailsCellType.settingsCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
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
