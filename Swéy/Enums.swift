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

enum SettingsScreenType: String {
    case settingsScreen = "Settings"
    case supportScreen = "Support"
    case sellingScreen = "Selling"
    case buyingScreen = "Buying"
    case safetyScreen = "Safety"
    case guideScreen = "Guide to SWÉY"
    case techIssueSccreen = "Technical Issues"
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

enum SettingsCellType: Int, CaseIterable {
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
            return "icDepositeMoney"
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

enum SupportCellType: Int, CaseIterable {
    case sellingCell = 0
    case buyingCell = 1
    case safetyCell = 2
    case guideToSweyCell = 3
    case technicalIssuesCell = 4
    
    func getCellLabelText() -> String {
        switch self {
        case .sellingCell:
            return "Selling"
        case .buyingCell:
            return "Buying"
        case .safetyCell:
            return "Safety"
        case .guideToSweyCell:
            return "Guide to SWÉY"
        case .technicalIssuesCell:
            return "Technical Issues"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .sellingCell:
            return "icSelling"
        case .buyingCell:
            return "icBuying"
        case .safetyCell:
            return "icSafety"
        case .guideToSweyCell:
            return "icGuideToSwey"
        case .technicalIssuesCell:
            return "icTechnicalIssues"
        }
    }
}


enum SellingCellType: Int, CaseIterable {
    case shippingCell = 0
    case paymentCell = 1
    case saleCell = 2
    
    func getCellLabelText() -> String {
        switch self {
        case .shippingCell:
            return "Selling"
        case .paymentCell:
            return "Buying"
        case .saleCell:
            return "Safety"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .shippingCell:
            return "icShipping"
        case .paymentCell:
            return "icPayment"
        case .saleCell:
            return "icSalling"
        }
    }
}

enum BuyingCellType: Int, CaseIterable {
    case purchaseHistoryCell = 0
    case authenticItemsCell = 1
    
    func getCellLabelText() -> String {
        switch self {
        case .purchaseHistoryCell:
            return "Purchase history"
        case .authenticItemsCell:
            return "How to buy Authentic items"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .purchaseHistoryCell:
            return "icPayment"
        case .authenticItemsCell:
            return "icAuthentic"
        }
    }
}

enum SafteyCellType: Int, CaseIterable {
    case reportUsersCell = 0
    case verifiedStoresCell = 1
    case standardAuthenticItemsCell = 2
    case verifiedOnlyStoresCell = 3
    
    func getCellLabelText() -> String {
        switch self {
        case .reportUsersCell:
            return "Report users"
        case .verifiedStoresCell:
            return "Verified stores"
        case .standardAuthenticItemsCell:
            return "Standard and sell authentic items"
        case .verifiedOnlyStoresCell:
            return "Only Shop at verified stores"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .reportUsersCell:
            return "icProfilePlaceHolder"
        case .verifiedStoresCell:
            return "icVerifiedStores"
        case .standardAuthenticItemsCell:
            return "icStandardAuthentic"
        case .verifiedOnlyStoresCell:
            return "icShopOnlyVerifiedStores"
        }
    }
}

enum GuideSweyCellType: Int, CaseIterable {
    case rulesCell = 0
    case termsOfServiceCell = 1
    
    func getCellLabelText() -> String {
        switch self {
        case .rulesCell:
            return "Rules"
        case .termsOfServiceCell:
            return "Terms of Service"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .rulesCell:
            return "icRules"
        case .termsOfServiceCell:
            return "icTermsAndService"
        }
    }
}

enum TechIssueCellType: Int, CaseIterable {
    case troubleShootCell = 0
    case restartCell = 1
    case uninstallAndRedownloadCell = 2
    
    func getCellLabelText() -> String {
        switch self {
        case .troubleShootCell:
            return "Troubleshoot"
        case .restartCell:
            return "Restart"
        case .uninstallAndRedownloadCell:
            return "Uninstall and redownload"
        }
    }
    
    func getCellIconImageName() -> String {
        switch self {
        case .troubleShootCell:
            return "icTroubleshoot"
        case .restartCell:
            return "icRestart"
        case .uninstallAndRedownloadCell:
            return "icUninstall"
        }
    }
}
