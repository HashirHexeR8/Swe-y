//
//  SettingsViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/15/23.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        
        let settingsCellNib = UINib(nibName: String(describing: SettingsTableViewCell.self), bundle: nil)
        self.settingsTableView.register(settingsCellNib, forCellReuseIdentifier: String(describing: SettingsTableViewCell.self))

    }
    
    @IBAction func onBackTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = SettingsCellType(rawValue: indexPath.row)
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self)) as! SettingsTableViewCell
        if let cellType = cellType {
            cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
        }
        return cell
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
