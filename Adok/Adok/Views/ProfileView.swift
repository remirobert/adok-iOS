//
//  ProfileView.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    lazy var profileImage: ProfileImage! = {
        let profileImage = ProfileImage(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 -
            (UIScreen.mainScreen().bounds.size.width / 3) / 2, 25, UIScreen.mainScreen().bounds.size.width / 3,
            UIScreen.mainScreen().bounds.size.width / 3))
        return profileImage
    }()

    override init() {
        super.init()
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height / 4)
        self.backgroundColor = UIColor(red:0.35, green:0.48, blue:0.97, alpha:1)
        self.addSubview(profileImage)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
