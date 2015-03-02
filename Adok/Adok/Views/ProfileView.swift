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
        let border = UIView(frame: CGRectMake(0, 57, UIScreen.mainScreen().bounds.size.width, 3))
        border.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1)
        statView.addSubview(border)
        return statView
    }()
        
    private func addLabel(position: CGPoint, title: String, value: String, parentView: UIView) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.sizeToFit()
        titleLabel.tag = 1
        titleLabel.frame.origin = CGPointMake(position.x - titleLabel.frame.size.width / 2, position.y)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = UIColor.whiteColor()
        valueLabel.font = UIFont.boldSystemFontOfSize(19)
        valueLabel.sizeToFit()
        valueLabel.frame.origin = CGPointMake(position.x - valueLabel.frame.size.width / 2, position.y + 20)
        valueLabel.tag = 1
        
        parentView.addSubview(titleLabel)
        parentView.addSubview(valueLabel)
    }
    
    func initLabelsStat(me: Me) {
        for currentsubView in self.statView.subviews {
            if (currentsubView as! UIView).tag == 1 {
               (currentsubView as! UIView).removeFromSuperview()
            }
        }
        
        addLabel(CGPointMake((UIScreen.mainScreen().bounds.size.width / 3) / 2, 10), title: "Photos", value: "\((me.images == nil) ? 0 : me.images)", parentView: statView)
        addLabel(CGPointMake((UIScreen.mainScreen().bounds.size.width / 3) / 2 + (UIScreen.mainScreen().bounds.size.width / 3), 10), title: "Friends", value: "\((me.friends == nil) ? 0 : me.friends)", parentView: statView)
        addLabel(CGPointMake((UIScreen.mainScreen().bounds.size.width / 3) / 2 + (UIScreen.mainScreen().bounds.size.width / 3 * 2), 10), title: "Badges", value: "\((me.badges == nil) ? 0 : me.badges)", parentView: statView)
    }
    
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
