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
        let login = UILabel(frame: CGRectMake(80, 7, UIScreen.mainScreen().bounds.size.width - 130, 13))
        login.textColor = UIColor.whiteColor()
        login.font = UIFont.boldSystemFontOfSize(15)
        login.backgroundColor = UIColor.redColor()
        return login
    }()
    
    lazy var time: UILabel! = {
       let time = UILabel(frame: CGRectMake(80, 25, UIScreen.mainScreen().bounds.size.width - 130, 10))
        time.textColor = UIColor.blackColor()
        time.font = UIFont.boldSystemFontOfSize(10)
        time.backgroundColor = UIColor.greenColor()
        return time
    }()
    lazy var contentLabel: UILabel! = {
       let contentLabel = UILabel(frame: CGRectMake(10, 35, UIScreen.mainScreen().bounds.size.width - 50, 50))
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.whiteColor()
        contentLabel.font = UIFont.boldSystemFontOfSize(15)
        contentLabel.textAlignment = NSTextAlignment.Center
        return contentLabel
    }()
    
    lazy var imageContent: UIImageView! = {
       let imageContent = UIImageView(frame: CGRectMake(40, 20, 50, 50))
        imageContent.layer.masksToBounds = true
        imageContent.layer.cornerRadius = imageContent.frame.size.height / 2
        imageContent.backgroundColor = UIColor.blueColor()
        return imageContent
    }()

    lazy var mainView: UIView! = {
        let mainView = UIView()
        mainView.frame = CGRectMake(20, 40, UIScreen.mainScreen().bounds.size.width - 40, 100)
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 7
        mainView.backgroundColor = UIColor.grayColor()
        return mainView
    }()
    
    var textContent: String {
        get {
            return contentLabel.text!
        }
        set {
            contentLabel.text = newValue
            contentLabel.sizeToFit()
//            if let mainView = self.contentView.viewWithTag(1) {
                mainView.frame.size.height = contentLabel.frame.size.height + 50
        }
    }
    
    class func calcHeightContent(challenge: Challenge) -> Float {
        var heightContent: Float = 35
        
        let styleText = NSMutableParagraphStyle()
        styleText.alignment = NSTextAlignment.Center
        let attributs = [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.boldSystemFontOfSize(15)]
        let sizeText = (challenge.content as NSString).sizeWithAttributes([NSParagraphStyleAttributeName:styleText,
            NSFontAttributeName:UIFont.boldSystemFontOfSize(15)])
        
        let sizeBounds = (challenge.content as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 40, UIScreen.mainScreen().bounds.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributs, context: nil)
        heightContent += Float(sizeBounds.height)
        println("size content : \(sizeText.height) \(sizeBounds.height)")
        return heightContent + 70
    }
    
    func initContentCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        login.text = "remi robert"
        time.text = "il y a 4 heures."
        contentLabel.text = "salut"
        mainView.addSubview(login)
        mainView.addSubview(time)
        mainView.addSubview(contentLabel)
        self.contentView.addSubview(mainView)
        self.contentView.addSubview(imageContent)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
    }
}
