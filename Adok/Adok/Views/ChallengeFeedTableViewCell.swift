//
//  ChallengeFeedTableViewCell.swift
//  Adok
//
//  Created by Remi Robert on 09/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ChallengeFeedTableViewCell: UITableViewCell {

    lazy var login: UILabel! = {
        let login = UILabel(frame: CGRectMake(60, 15, UIScreen.mainScreen().bounds.size.width / 2, 20))
        login.textColor = UIColor(red:0.07, green:0.47, blue:0.84, alpha:1)
        login.font = UIFont.boldSystemFontOfSize(17)
        login.numberOfLines = 1
        login.backgroundColor = UIColor.clearColor()
        return login
    }()
    
    lazy var time: UILabel! = {
       let time = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2, 15, UIScreen.mainScreen().bounds.size.width / 2 - 30, 20))
        time.textColor = UIColor.blackColor()
        time.textAlignment = NSTextAlignment.Right
        time.font = UIFont.systemFontOfSize(11)
        time.backgroundColor = UIColor.clearColor()
        return time
    }()
    
    lazy var contentLabel: UILabel! = {
       let contentLabel = UILabel(frame: CGRectMake(10, 55, UIScreen.mainScreen().bounds.size.width - 40, 50))
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor(red:0.46, green:0.46, blue:0.45, alpha:1)
        contentLabel.font = UIFont.boldSystemFontOfSize(15)
        contentLabel.textAlignment = NSTextAlignment.Center
        contentLabel.layer.cornerRadius = 5
        return contentLabel
    }()
    
    lazy var profilePicutre: UIImageView! = {
       let profilePicutre = UIImageView(frame: CGRectMake(5, 5, 40, 40))
        profilePicutre.layer.masksToBounds = true
        profilePicutre.layer.cornerRadius = profilePicutre.frame.size.height / 2
        profilePicutre.backgroundColor = UIColor.blueColor()
        return profilePicutre
    }()
    
    lazy var pictureContent: ParallaxImage! = {
        let pictureContent = ParallaxImage(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width - 20, 100))
        return pictureContent
    }()

    lazy var mainView: UIView! = {
        let mainView = UIView()
        mainView.frame = CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, 0)
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.layer.shadowColor = UIColor.grayColor().CGColor
        mainView.layer.shadowOffset = CGSizeMake(0, 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.cornerRadius = 5
        return mainView
    }()
    
    lazy var viewContentProfile: UIView! = {
        let viewContentProfile = UIView(frame: CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, 50))
        viewContentProfile.backgroundColor = UIColor(red:0.96, green:0.97, blue:0.96, alpha:1)
        viewContentProfile.layer.masksToBounds = true
        return viewContentProfile
    }()
    
    var loginContent: String {
        get {
            return login.text!
        }
        set {
            login.text = newValue
        }
    }
    
    var textContent: String {
        get {
            return contentLabel.text!
        }
        set {
            contentLabel.text = newValue
            contentLabel.sizeToFit()
            contentLabel.frame.origin.y = viewContentProfile.frame.origin.y + viewContentProfile.frame.size.height + 10
            contentLabel.frame.origin.x = 10
            contentLabel.frame.size.width = mainView.frame.size.width - 20
            contentLabel.textAlignment = NSTextAlignment.Center
            mainView.frame.size.height = contentLabel.frame.origin.y + contentLabel.frame.size.height + 20
        }
    }
    
    var imageContent: UIImage! {
        get {
            return pictureContent.image!
        }
        set {
            if (newValue == nil) {
                pictureContent.frame.size.height = 0
                return
            }
            pictureContent.image = newValue
            pictureContent.frame.size.height = 100
            mainView.frame.size.height += pictureContent.frame.size.height
            pictureContent.frame.origin.y = mainView.frame.size.height - pictureContent.frame.size.height
        }
    }
    
    var loginPicture: UIImage! {
        get {
            return profilePicutre.image!
        }
        set {
            profilePicutre.image = newValue
        }
    }
    
    func cellOnTableView(tableView: UITableView, didScrollOnView view: UIView) {
        if (pictureContent.frame.size.height == 0) {
            return
        }
        let rectCell = CGRectOffset(self.frame, -tableView.contentOffset.x, -tableView.contentOffset.y);
        let percent = (rectCell.origin.y - mainView.frame.origin.y + 64 + 49 + 10) / view.frame.height * 100
        let originTop = 70 * percent / 100
        pictureContent.imageContent.frame.origin.y = originTop - 70
        if (pictureContent.imageContent.frame.origin.y < -70) {
            pictureContent.imageContent.frame.origin.y = -70
        }
        if (pictureContent.imageContent.frame.origin.y > 0) {
            pictureContent.imageContent.frame.origin.y = 0
        }
    }
    
    class func calcHeightContent(challenge: Challenge) -> Float {
        var heightContent: Float = 50
        
        let styleText = NSMutableParagraphStyle()
        styleText.alignment = NSTextAlignment.Center
        let attributs = [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.boldSystemFontOfSize(15)]
        let sizeBoundsContent = (challenge.content as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 40,
            UIScreen.mainScreen().bounds.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributs, context: nil)

        heightContent += Float(sizeBoundsContent.height)
        return heightContent + ((challenge.pictureUrl == nil) ? 0 : 105) + 50
    }
    
    func initContentCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor(red:0.9, green:0.91, blue:0.9, alpha:1)
        mainView.addSubview(time)
        mainView.addSubview(contentLabel)
        mainView.addSubview(pictureContent)
        
        time.text = "7 heures"
        viewContentProfile.addSubview(profilePicutre)
        viewContentProfile.addSubview(login)
        viewContentProfile.addSubview(time)
        self.contentView.addSubview(mainView)
        self.contentView.addSubview(viewContentProfile)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
    }
}
