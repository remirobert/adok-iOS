//
//  ProfileController.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    lazy var profileView: ProfileView! = {
        let profileView = ProfileView()
        return profileView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.profileImage.setImageProfile(UIImage(named: "profile"))
        self.view.addSubview(profileView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
