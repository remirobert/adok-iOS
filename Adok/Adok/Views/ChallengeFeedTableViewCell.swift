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
        let login = UILabel(frame: CGRectMake(10, 15, UIScreen.mainScreen().bounds.size.width - 80, 13))
        login.textColor = UIColor.grayColor()//UIColor(red:0.14, green:0.12, blue:0.13, alpha:1)
        login.font = UIFont.boldSystemFontOfSize(17)
        login.numberOfLines = 0
        login.backgroundColor = UIColor.clearColor()
        return login
    }()
    
    lazy var time: UILabel! = {
       let time = UILabel(frame: CGRectMake(80, 25, UIScreen.mainScreen().bounds.size.width - 130, 10))
        time.textColor = UIColor.blackColor()
        time.font = UIFont.boldSystemFontOfSize(10)
        time.backgroundColor = UIColor.clearColor()
        return time
    }()
    
    lazy var contentLabel: UILabel! = {
       let contentLabel = UILabel(frame: CGRectMake(10, 45, UIScreen.mainScreen().bounds.size.width - 40, 50))
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.blackColor()
        contentLabel.font = UIFont.boldSystemFontOfSize(15)
        contentLabel.textAlignment = NSTextAlignment.Center
        return contentLabel
    }()
    
    lazy var profilePicutre: UIImageView! = {
       let profilePicutre = UIImageView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width - 70, 20, 50, 50))
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
        mainView.frame = CGRectMake(10, 40, UIScreen.mainScreen().bounds.size.width - 20, 0)
        mainView.layer.shadowColor = UIColor.grayColor().CGColor
        mainView.layer.shadowOffset = CGSizeMake(0, 1)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 1

        mainView.backgroundColor = UIColor.whiteColor()
        return mainView
    }()
    
    var loginContent: String {
        get {
            return login.text!
        }
        set {
            login.text = newValue
            login.sizeToFit()
            login.frame.size.width = mainView.frame.size.width - 60
        }
    }
    
    var textContent: String {
        get {
            return contentLabel.text!
        }
        set {
            contentLabel.text = newValue
            contentLabel.sizeToFit()
            contentLabel.frame.origin.y = login.frame.origin.y + login.frame.size.height + 10
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
            profilePicutre.frame.origin.y += pictureContent.frame.size.height - 20
            login.frame.origin.y += pictureContent.frame.size.height
            time.frame.origin.y += pictureContent.frame.size.height
            contentLabel.frame.origin.y += pictureContent.frame.size.height
            mainView.frame.origin.y -= 20
            let flat = UIView(frame: CGRectMake(0, mainView.frame.size.height - 1, mainView.frame.size.width, 1))
            flat.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(1)
            mainView.addSubview(flat)
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
        let percent = (rectCell.origin.y - 10) / view.frame.height * 100
        let originTop = 70 * percent / 100
        pictureContent.imageContent.frame.origin.y = originTop - 70
    }
    
    class func calcHeightContent(challenge: Challenge) -> Float {
        var heightContent: Float = 20
        
        let styleText = NSMutableParagraphStyle()
        styleText.alignment = NSTextAlignment.Center
        let attributs = [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.boldSystemFontOfSize(15)]
        let sizeBoundsLoginContent = (challenge.login as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 80,
            UIScreen.mainScreen().bounds.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.boldSystemFontOfSize(17)], context: nil)
        let sizeBoundsContent = (challenge.content as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 40,
            UIScreen.mainScreen().bounds.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributs, context: nil)

        heightContent += Float(sizeBoundsContent.height + sizeBoundsLoginContent.height)
        return heightContent + 70 + ((challenge.pictureUrl == nil) ? 0 : 80)
    }
    
    func initContentCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        mainView.addSubview(login)
        mainView.addSubview(time)
        mainView.addSubview(contentLabel)
        mainView.addSubview(pictureContent)
        self.contentView.addSubview(mainView)
        self.contentView.addSubview(profilePicutre)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
    }
}
