//
//  ChallengeProfileViewCell.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ChallengeProfileViewCell: UITableViewCell {

    private lazy var imageLogin: UIImageView! = {
        let imageLogin = UIImageView(frame: CGRectMake(10, 10, 50, 50))
        imageLogin.contentMode = UIViewContentMode.ScaleAspectFill
        imageLogin.layer.masksToBounds = true
        imageLogin.layer.cornerRadius = 25
        return imageLogin
    }()
    
    private lazy var loginLabel: UILabel! = {
        let loginLabel = UILabel(frame: CGRectMake(80, 10, UIScreen.mainScreen().bounds.size.width - 100, 20))
        loginLabel.numberOfLines = 0
        loginLabel.font = UIFont.boldSystemFontOfSize(18)
        loginLabel.textColor = UIColor.blackColor()
        return loginLabel
    }()
    
    private lazy var contentChallengeLabel: UILabel! = {
        let contentChallengeLabel = UILabel(frame: CGRectMake(80, 30, UIScreen.mainScreen().bounds.size.width - 100, 20))
        contentChallengeLabel.numberOfLines = 0
        contentChallengeLabel.font = UIFont.systemFontOfSize(17)
        contentChallengeLabel.textColor = UIColor.blackColor()
        return contentChallengeLabel
    }()
    
    var loginString: String {
        get {
            return loginLabel.text!
        }
        set {
            loginLabel.text = newValue
            loginLabel.sizeToFit()
            loginLabel.frame.size.width = UIScreen.mainScreen().bounds.size.width - 100
        }
    }
    
    var contentString: String {
        get {
            return contentChallengeLabel.text!
        }
        set {
            contentChallengeLabel.text = newValue
            contentChallengeLabel.sizeToFit()
            contentChallengeLabel.frame.size.width = UIScreen.mainScreen().bounds.size.width - 100
        }
    }

    var imageProfile: UIImage? {
        get {
            return imageLogin.image
        }
        set {
            if (newValue != nil) {
                imageLogin.image = newValue
            }
        }
    }
    
    class func calcHeightContent(challenge: Challenge) -> Float {
        var heightContent: Float = 20
        let styleText = NSMutableParagraphStyle()
        styleText.alignment = NSTextAlignment.Center
        let attributsLogin = [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.boldSystemFontOfSize(18)]
        let attributsContent = [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.systemFontOfSize(17)]
//        let sizeBoundsLoginContent = (challenge.login as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 80,
//            UIScreen.mainScreen().bounds.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributsLogin, context: nil)
//        let sizeBoundsContent = (challenge.content as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 80,
//            UIScreen.mainScreen().bounds.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributsContent, context: nil)
//        heightContent += Float(sizeBoundsContent.height + sizeBoundsLoginContent.height)
        return heightContent
    }
    
    func initContentCell() {
        self.contentView.addSubview(imageLogin)
        self.contentView.addSubview(loginLabel)
        self.contentView.addSubview(contentChallengeLabel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
