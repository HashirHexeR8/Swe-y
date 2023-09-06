//
//  CustomTableView.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/4/23.
//

import Foundation
import UIKit

final class CustomTableView: UITableView {
    override var intrinsicContentSize: CGSize {
            self.layoutIfNeeded()
            return self.contentSize
        }
    override var contentSize: CGSize {
            didSet {
                self.invalidateIntrinsicContentSize()
            }
        }
    override func reloadData() {
            super.reloadData()
            self.invalidateIntrinsicContentSize()
        }
}
