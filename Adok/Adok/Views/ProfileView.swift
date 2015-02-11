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
        let sizeImageprofileView: CGFloat = 70.0
        let profileImage = ProfileImage(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 -
            sizeImageprofileView / 2, 25, sizeImageprofileView,
            sizeImageprofileView))
        return profileImage
    }()

    lazy var labelLogin: UILabel! = {
        let labelLogin = UILabel(frame: CGRectMake(10, self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20,
            UIScreen.mainScreen().bounds.size.width - 20, 20))
        labelLogin.textAlignment = NSTextAlignment.Center
        labelLogin.textColor = UIColor.whiteColor()
        labelLogin.font = UIFont.boldSystemFontOfSize(15)
        return labelLogin
    }()
    
    override init() {
        super.init()
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height / 4)
        self.backgroundColor = UIColor(red:0.35, green:0.48, blue:0.97, alpha:1)
        self.addSubview(profileImage)
        self.addSubview(labelLogin)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
