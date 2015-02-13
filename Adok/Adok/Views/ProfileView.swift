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
            sizeImageprofileView / 2, 20, sizeImageprofileView,
            sizeImageprofileView))
        return profileImage
    }()

    lazy var labelLogin: UILabel! = {
        let labelLogin = UILabel(frame: CGRectMake(10, self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 15,
            UIScreen.mainScreen().bounds.size.width - 20, 20))
        labelLogin.textAlignment = NSTextAlignment.Center
        labelLogin.textColor = UIColor.whiteColor()
        labelLogin.font = UIFont.boldSystemFontOfSize(15)
        return labelLogin
    }()
    
    lazy var statView: UIView! = {
        let statView = UIView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height / 4, UIScreen.mainScreen().bounds.size.width, 60))
        statView.backgroundColor = UIColor(red:0.13, green:0.24, blue:0.57, alpha:1)
        
        let camera = UIButton(frame: CGRectMake((UIScreen.mainScreen().bounds.size.width / 3) / 2 - 20, 0, 40, 40))
        camera.setImage(UIImage(named: "camera"), forState: UIControlState.Normal)
        camera.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        camera.imageView?.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        let friends = UIButton(frame: CGRectMake((UIScreen.mainScreen().bounds.size.width / 3) / 2 - 20 + (UIScreen.mainScreen().bounds.size.width / 3), 0, 40, 40))
        friends.setImage(UIImage(named: "network"), forState: UIControlState.Normal)

        let challenges = UIButton(frame: CGRectMake((UIScreen.mainScreen().bounds.size.width / 3) / 2 - 20 + (UIScreen.mainScreen().bounds.size.width / 3 * 2), 0, 40, 40))
        challenges.setImage(UIImage(named: "challengeCheck"), forState: UIControlState.Normal)
        
        statView.addSubview(friends)
        statView.addSubview(challenges)
        statView.addSubview(camera)
        return statView
    }()
    
    override init() {
        super.init()
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height / 4 + 60)
        self.backgroundColor = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        self.addSubview(profileImage)
        self.addSubview(labelLogin)
        self.addSubview(statView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
