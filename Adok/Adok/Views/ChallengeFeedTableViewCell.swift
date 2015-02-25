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
        let login = UILabel(frame: CGRectMake(65, 25, UIScreen.mainScreen().bounds.size.width / 2, 20))
        login.textColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1)
        login.font = UIFont.boldSystemFontOfSize(17)
        login.numberOfLines = 1
        login.backgroundColor = UIColor.clearColor()
        return login
    }()
    
    lazy var time: UILabel! = {
       let time = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2, 25, UIScreen.mainScreen().bounds.size.width / 2 - 30, 20))
        time.textColor = UIColor(red:0.64, green:0.64, blue:0.64, alpha:1)
        time.textAlignment = NSTextAlignment.Right
        time.font = UIFont.systemFontOfSize(11)
        time.backgroundColor = UIColor.clearColor()
        return time
    }()
    
    lazy var contentLabel: UILabel! = {
       let contentLabel = UILabel(frame: CGRectMake(10, 55, UIScreen.mainScreen().bounds.size.width - 40, 50))
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor(red:0.23, green:0.23, blue:0.23, alpha:1)
        contentLabel.font = UIFont.boldSystemFontOfSize(15)
        contentLabel.textAlignment = NSTextAlignment.Center
        contentLabel.layer.cornerRadius = 5
        return contentLabel
    }()
    
    lazy var profilePicutre: UIImageView! = {
       let profilePicutre = UIImageView(frame: CGRectMake(15, 15, 40, 40))
        profilePicutre.layer.masksToBounds = true
        profilePicutre.layer.cornerRadius = profilePicutre.frame.size.height / 2
        profilePicutre.backgroundColor = UIColor.blueColor()
        return profilePicutre
    }()
    
    lazy var pictureContent: UIImageView! = {
        let imageContent = UIImageView()
        imageContent.frame = CGRectMake(10, 40, UIScreen.mainScreen().bounds.size.width - 40, 200)
        imageContent.contentMode = UIViewContentMode.ScaleAspectFill
        imageContent.layer.masksToBounds = true
        return imageContent
    }()

    lazy var mainView: UIView! = {
        let mainView = UIView()
        mainView.frame = CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, 0)
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 5
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1).CGColor
        return mainView
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
            contentLabel.frame.origin.y = profilePicutre.frame.origin.y + profilePicutre.frame.size.height + 20 //viewContentProfile.frame.origin.y// + viewContentProfile.frame.size.height + 10
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
            pictureContent.frame.size.height = 200
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
    
    func updateContent() {
        if (pictureContent.image != nil) {
            mainView.frame.size.height += pictureContent.frame.size.height
            pictureContent.frame.origin.y = mainView.frame.size.height - pictureContent.frame.size.height
        }
        pictureContent.frame.origin.y = mainView.frame.size.height - pictureContent.frame.size.height
    }
    
    func cellOnTableView(tableView: UITableView, didScrollOnView view: UIView) {
        if (pictureContent.frame.size.height == 0) {
            return
        }
        let rectCell = CGRectOffset(self.frame, -tableView.contentOffset.x, -tableView.contentOffset.y);
        let percent = (rectCell.origin.y - mainView.frame.origin.y + 64 + 49 + 10) / view.frame.height * 100
        let originTop = 70 * percent / 100
        pictureContent.frame.origin.y = originTop - 70
        if (pictureContent.frame.origin.y < -70) {
            pictureContent.frame.origin.y = -70
        }
        if (pictureContent.frame.origin.y > 0) {
            pictureContent.frame.origin.y = 0
        }
    }
    
    class func calcHeightContent(challenge: Challenge) -> Float {
        var heightContent: Float = 50
        
        let styleText = NSMutableParagraphStyle()
        styleText.alignment = NSTextAlignment.Center
        let attributs = [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.boldSystemFontOfSize(15)]
        let sizeBoundsContent = (challenge.title as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 40,
            UIScreen.mainScreen().bounds.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributs, context: nil)

        heightContent += Float(sizeBoundsContent.height)
        return heightContent + ((challenge.picture == nil || challenge.picture == "") ? 0 : 200) + 60
        //return heightContent + 60
    }
    
    func initContentCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.clearColor()//UIColor(red:0.9, green:0.91, blue:0.9, alpha:1)
        mainView.addSubview(time)
        mainView.addSubview(contentLabel)
        mainView.addSubview(pictureContent)
        
        time.text = "7m"
        mainView.addSubview(profilePicutre)
        mainView.addSubview(login)
        mainView.addSubview(time)

        self.contentView.addSubview(mainView)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
    }
}
