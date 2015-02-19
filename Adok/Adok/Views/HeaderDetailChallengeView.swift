//
//  HeaderDetailChallengeView.swift
//  Adok
//
//  Created by Remi Robert on 18/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class HeaderDetailChallengeView: UICollectionReusableView {
    
    var heightContent: CGFloat!
    
    lazy var login: UILabel! = {
        let login = UILabel(frame: CGRectMake(65, 25, UIScreen.mainScreen().bounds.size.width / 2, 20))
        login.textColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1)
        login.font = UIFont.boldSystemFontOfSize(17)
        login.numberOfLines = 1
        login.backgroundColor = UIColor.clearColor()
        return login
    }()
    
    lazy var time: UILabel! = {
        let time = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2, 25,
            UIScreen.mainScreen().bounds.size.width / 2 - 30, 20))
        time.textColor = UIColor(red:0.64, green:0.64, blue:0.64, alpha:1)
        time.textAlignment = NSTextAlignment.Right
        time.font = UIFont.systemFontOfSize(11)
        time.backgroundColor = UIColor.clearColor()
        return time
    }()
    
    lazy var profilePicutre: UIImageView! = {
        let profilePicutre = UIImageView(frame: CGRectMake(15, 15, 40, 40))
        profilePicutre.layer.masksToBounds = true
        profilePicutre.layer.cornerRadius = profilePicutre.frame.size.height / 2
        profilePicutre.backgroundColor = UIColor.blueColor()
        return profilePicutre
    }()
    
    lazy var contentLabel: UILabel! = {
        let contentLabel = UILabel(frame: CGRectMake(20, 65, UIScreen.mainScreen().bounds.size.width - 40, 50))
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor(red:0.23, green:0.23, blue:0.23, alpha:1)
        contentLabel.font = UIFont.boldSystemFontOfSize(15)
        contentLabel.textAlignment = NSTextAlignment.Center
        contentLabel.layer.cornerRadius = 5
        return contentLabel
    }()

    lazy var descLabel: UILabel! = {
        let descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textColor = UIColor(red:0.23, green:0.23, blue:0.23, alpha:1)
        descLabel.font = UIFont.boldSystemFontOfSize(13)
        descLabel.textAlignment = NSTextAlignment.Center
        return descLabel
    }()
    
    lazy var pictureContent: UIImageView! = {
        let pictureContent = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 200))
        pictureContent.contentMode = UIViewContentMode.ScaleAspectFill
        pictureContent.backgroundColor = UIColor.blueColor()
        pictureContent.layer.masksToBounds = true
        return pictureContent
    }()

    func initContent(challenge: Challenge) {
        if login.superview == nil && time.superview == nil &&
            profilePicutre.superview == nil && contentLabel.superview == nil &&
            pictureContent.superview == nil && descLabel.superview == nil {
            self.addSubview(login)
            self.addSubview(time)
            self.addSubview(profilePicutre)
            self.addSubview(contentLabel)
            self.addSubview(pictureContent)
            self.addSubview(descLabel)
        }
        login.text = challenge.user.full
        time.text = "7m"
        profilePicutre.sd_setImageWithURL(NSURL(string: challenge.user.picture))
        contentLabel.text = challenge.title
        contentLabel.sizeToFit()
        contentLabel.frame.size.width = UIScreen.mainScreen().bounds.size.width - 40
        
        heightContent = contentLabel.frame.origin.y + contentLabel.frame.size.height + 20
        
        pictureContent.frame.origin.y = contentLabel.frame.origin.y + contentLabel.frame.size.height + 20
        pictureContent.image = UIImage(named: "img")
        
        heightContent = pictureContent.frame.origin.y + pictureContent.frame.size.height + 20
        
        if (challenge.desc.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {
            descLabel.frame.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 40, 20)
            descLabel.text = challenge.desc
            descLabel.sizeToFit()
            descLabel.frame.origin.x = 20
            descLabel.frame.origin.y = pictureContent.frame.origin.y + pictureContent.frame.size.height + 20
            
            heightContent = descLabel.frame.origin.y + descLabel.frame.size.height + 20
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
