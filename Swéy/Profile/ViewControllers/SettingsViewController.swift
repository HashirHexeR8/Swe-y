//
//  SettingsViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/15/23.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var screenLabel: UILabel!
    
    var screenType: SettingsScreenType = .settingsScreen

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        
        let settingsCellNib = UINib(nibName: String(describing: SettingsTableViewCell.self), bundle: nil)
        self.settingsTableView.register(settingsCellNib, forCellReuseIdentifier: String(describing: SettingsTableViewCell.self))
        
        ///Setting screen title here.
        self.screenLabel.text = screenType.rawValue

    }
    
    @IBAction func onBackTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch screenType {
        case .settingsScreen:
            return SettingsCellType.allCases.count
        case .supportScreen:
            return SupportCellType.allCases.count
        case .sellingScreen:
            return SellingCellType.allCases.count
        case .buyingScreen:
            return BuyingCellType.allCases.count
        case .safetyScreen:
            return SafteyCellType.allCases.count
        case .guideScreen:
            return GuideSweyCellType.allCases.count
        case .techIssueSccreen:
            return TechIssueCellType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self)) as! SettingsTableViewCell
        
        switch screenType {
        case .settingsScreen:
            let cellType = SettingsCellType(rawValue: indexPath.row)
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
            }
        case .supportScreen:
            let cellType = SupportCellType(rawValue: indexPath.row)
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
            }
        case .sellingScreen:
            let cellType = SellingCellType(rawValue: indexPath.row)
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
            }
        case .buyingScreen:
            let cellType = BuyingCellType(rawValue: indexPath.row)
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
            }
        case .safetyScreen:
            let cellType = SafteyCellType(rawValue: indexPath.row)
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
            }
        case .guideScreen:
            let cellType = GuideSweyCellType(rawValue: indexPath.row)
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
            }
        case .techIssueSccreen:
            let cellType = TechIssueCellType(rawValue: indexPath.row)
            if let cellType = cellType {
                cell.setupCell(labelText: cellType.getCellLabelText(), iconImage: UIImage(named: cellType.getCellIconImageName()), isModeSwitch: false, isProfileImage: false)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if screenType == .supportScreen {
            handleSupportScreenNavigation(indexPath: indexPath)
        }
        else if screenType == .settingsScreen {
            handleSettingsScreenNavigation(indexPath: indexPath)
        }
    }
    
    func handleSettingsScreenNavigation(indexPath: IndexPath) {
        if indexPath.row == SettingsCellType.billingCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: BillingDetailsViewController.self)) as? BillingDetailsViewController
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
    }
    
    func handleSupportScreenNavigation(indexPath: IndexPath) {
        
        if indexPath.row == SupportCellType.sellingCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController
            vc?.screenType = .sellingScreen
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
        else if indexPath.row == SupportCellType.buyingCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController
            vc?.screenType = .buyingScreen
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
        else if indexPath.row == SupportCellType.safetyCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController
            vc?.screenType = .safetyScreen
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
        else if indexPath.row == SupportCellType.guideToSweyCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController
            vc?.screenType = .guideScreen
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
        else if indexPath.row == SupportCellType.technicalIssuesCell.rawValue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as? SettingsViewController
            vc?.screenType = .techIssueSccreen
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
