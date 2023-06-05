//
//  PreviewViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/6/23.
//

import UIKit

class PreviewViewController: UIViewController {
    private let imageView = UIImageView()

    override func loadView() {
        view = imageView
    }

    init(imageName: String) {
        super.init(nibName: nil, bundle: nil)

        // Set up our image view and display the pupper
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: imageName)

        // By setting the preferredContentSize to the image size,
        // the preview will have the same aspect ratio as the image
        preferredContentSize = UIImage(named: imageName)?.size ?? CGSize(width: 100, height: 100)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
