//
//  Enums.swift
//  Swey
//
//  Created by Muhammad Hashir on 5/14/23.
//

import Foundation

enum ListingPageSectionType {
    case categoriesSection
    case normalProductSection
    case verticalProductSection
    case horizontalProductSection
}

enum ProductItemType {
    case verticalGroupItem
    case verticalItem
    case horizontalGroupItem
    case horizontalItem
}

enum ProfileDetailsCellType: Int {
    case profileCell = 0
    case privacyAndSafetyCell = 1
    case contentAndPreferencesCell = 2
    case settingsCell = 3
    case discountsCell = 4
    case supportCell = 5
    case darkModeCell = 6
    case switchAccountButtonCell = 7
    case addAccountButtonCell = 8
    case logoutButtonCell = 9
    case appVersionCell = 10
    
    func getCellLabelText() -> String {
        switch self {
        case .profileCell:
            return "Profile"
        case .privacyAndSafetyCell:
            return "Privacy and safety"
        case .contentAndPreferencesCell:
            return "Content preferences"
        case .settingsCell:
            return "Settings"
        case .discountsCell:
            return "Discounts"
        case .supportCell:
            return "Support"
        case .darkModeCell:
            return "Dark mode"
        case .switchAccountButtonCell:
            return "Switch Account"
        case .addAccountButtonCell:
            return "Add Account"
        case .logoutButtonCell:
            return "Log Out"
        case .appVersionCell:
            return "Version 1.0.0"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .profileCell:
            return "icProfilePlaceHolder"
        case .privacyAndSafetyCell:
            return "icPrivacyAndSafety"
        case .contentAndPreferencesCell:
            return "icContentPreferences"
        case .settingsCell:
            return "icSettings"
        case .discountsCell:
            return "icDiscount"
        case .supportCell:
            return "icSupport"
        case .darkModeCell:
            return "icDarkMode"
        case .switchAccountButtonCell:
            return "Switch Account"
        case .addAccountButtonCell:
            return "Add Account"
        case .logoutButtonCell:
            return "Log Out"
        case .appVersionCell:
            return "Version 1.0.0"
        }
    }
}

enum SettingsCellType: Int {
    case cardsCell = 0
    case depositeMoneyCell = 1
    case convertSweyCoinCell = 2
    case paypalCell = 3
    case currencyCell = 4
    case billingCell = 5
    case notificationCell = 6
    
    func getCellLabelText() -> String {
        switch self {
        case .cardsCell:
            return "Cards"
        case .depositeMoneyCell:
            return "Desposit money in Swey account"
        case .convertSweyCoinCell:
            return "Convert Swey coin"
        case .paypalCell:
            return "PayPal"
        case .currencyCell:
            return "Currency"
        case .billingCell:
            return "Billing"
        case .notificationCell:
            return "Notification"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .cardsCell:
            return "icCardSettings"
        case .depositeMoneyCell:
            return "icDepositeMoney "
        case .convertSweyCoinCell:
            return "icSweyCoin"
        case .paypalCell:
            return "icPaypal"
        case .currencyCell:
            return "icCurrency"
        case .billingCell:
            return "icBilling"
        case .notificationCell:
            return "icNotification"
        }
    }
}
