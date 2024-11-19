//
//  ProfilePictureViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit
import MobileCoreServices
import AVKit

class ProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var userSignupDTO : UserSignupRequestDTO?
    private var isImageSelected: Bool = false
    
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
        if isImageSelected {
            SweyAlertController.showLoadingAlert(message: "Signing Up...", vc: self)
            Task {
                do {
                    try await AuthService.sharedInstance.signupUser(signupDTO: self.userSignupDTO!)
                    DispatchQueue.main.async {
                        SweyAlertController.hideLoadingAlert()
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as? SignInViewController
                        vc?.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        SweyAlertController.hideLoadingAlert()
                        SweyAlertController.showAlert(title: "Error", message: "Unable to signup at this moment", vc: self)
                    }
                }
            }
        }
        showImageSourceOptions()
    }
    
    // Show alert with options to choose between camera and photo library
    func showImageSourceOptions() {
        let alert = UIAlertController(title: "Select Image", message: "Choose source", preferredStyle: .actionSheet)
        
        // Option to choose from the Photo Library
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                self.openImagePicker(sourceType: .photoLibrary)
            }))
        }
        
        // Option to use the Camera (ensure camera is available and authorized)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.openImagePicker(sourceType: .camera)
            }))
        }
        
        // Cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    
    // Open the image picker with the selected source type (camera or photo library)
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        // Check for permission (camera or photo library)
        if sourceType == .camera {
            // Request camera access if not authorized
            AVCaptureDevice.requestAccess(for: .video) { response in
                if response {
                    DispatchQueue.main.async {
                        self.presentImagePicker(sourceType: sourceType)
                    }
                } else {
                    self.showPermissionAlert(message: "Camera access is required.")
                }
            }
        } else {
            // For photo library, no extra permissions required
            presentImagePicker(sourceType: sourceType)
        }
    }
    
    // Present the image picker view controller
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        pickerController.mediaTypes = [kUTTypeImage as String] // Only images
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    // Handle the selected image or photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the selected image
        if let image = info[.originalImage] as? UIImage {
            selectedImageView.image = image
        }
        
        // Dismiss the picker view
        dismiss(animated: true, completion: nil)
    }
    
    // Handle cancellation
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show an alert when permission is denied or other error occurs
    func showPermissionAlert(message: String) {
        let alert = UIAlertController(title: "Permission Denied", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
