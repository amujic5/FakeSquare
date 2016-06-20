//
//  ProfileDetailsViewController.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 20/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class ProfileDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginParentView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    
    weak var profileImageView: UIImageView?
    var models: [String] = ["Change profile picture"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = FBSDKProfilePictureView()
        imageContainerView.addSubview(imageView)
        imageView.frame = imageContainerView .bounds
        if FBSDKAccessToken.currentAccessToken() != nil {
            imageView.profileID = FBSDKAccessToken.currentAccessToken().userID
        }
        
        let loginButton = FBSDKLoginButton()
        loginParentView.addSubview(loginButton)
        loginButton.publishPermissions = ["publish_actions", ]
        loginButton.frame = loginParentView.bounds
        
        loadFacebookStuff()
    }

    func showAlertForNewPhoto() {
        UIActionSheet(title: nil,
            delegate: self,
            cancelButtonTitle: "Cancel",
            destructiveButtonTitle: nil,
            otherButtonTitles: "From Library",
            "Take A Picture")
            .showInView(view)
    }
    
    func showImagePicker(sourceType sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        navigationController?.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func loadFacebookStuff() {
        if FBSDKAccessToken.currentAccessToken() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: nil, HTTPMethod: "GET")
                .startWithCompletionHandler({ (connection, result, error) in
                    if result != nil && error == nil {
                        self.models.append(result["name"] as! String)
                        self.tableView.reloadData()
                        print(result)
                    }
                })
        }

    }
    
}

// MARK: UIActionSheetDelegate

extension ProfileDetailsViewController: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            showImagePicker(sourceType: UIImagePickerControllerSourceType.PhotoLibrary)
        } else if buttonIndex == 2 {
            showImagePicker(sourceType: UIImagePickerControllerSourceType.Camera)
        }
    }
    
}

// MARK: UIImagePickerControllerDelegate

extension ProfileDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageView = UIImageView(image: pickedImage)
            imageContainerView.addSubview(imageView)
            imageView.frame = imageContainerView.bounds
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension ProfileDetailsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = UITableViewCell()
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text = models[indexPath.row]
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cell = UITableViewCell()
            cell.textLabel?.text = models[indexPath.row]
        }
        
        return cell
    }
}


extension ProfileDetailsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0 {
            showAlertForNewPhoto()
        }
    }
    
}