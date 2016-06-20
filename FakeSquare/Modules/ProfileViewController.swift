//
//  ProfileViewController.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if FBSDKAccessToken.currentAccessToken() != nil {
            performSegueWithIdentifier(String(ProfileDetailsViewController), sender: nil)
        }
        
    }

}
