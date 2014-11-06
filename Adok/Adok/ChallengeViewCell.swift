//
//  ChallengeViewCell.swift
//  Hadok
//
//  Created by Remi Robert on 10/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class ChallengeViewCell: UITableViewCell {

    var viewContent = UIView()
    var dateChallenge = UILabel()
    var profilePicture = UIImageView()
    var challengeText = UITextView()
    var pseudo = UILabel()
    var height: CGFloat?
    
    func addImageProfile() {
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.height / 2
    }

    func addPseudo() {
        self.pseudo.textColor = UIColor.blackColor()
    }
    
    func addTextChallenge() {
        self.challengeText.backgroundColor = UIColor.clearColor()

        self.challengeText.font = UIFont(name: "Jaapokki-Regular", size: 14)
        self.challengeText.textColor = UIColor.grayColor()
        self.challengeText.scrollEnabled = false

        self.challengeText.sizeToFit()
        self.viewContent.frame = CGRectMake(self.viewContent.frame.origin.x, self.viewContent.frame.origin.y,
            self.viewContent.frame.size.width, self.viewContent.frame.size.height + self.challengeText.frame.size.height)
    }
    
    func initContentCell(content: ChallengeContent) {
        
        self.viewContent.layer.cornerRadius = 10
        self.viewContent.backgroundColor = UIColor.whiteColor()
        self.backgroundColor = UIColor.clearColor()
        
        self.height = self.viewContent.frame.size.height
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, self.contentView.frame.size.height + 20)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.viewContent.frame = CGRectMake(7, 7, UIScreen.mainScreen().bounds.size.width - 14, 50)
        self.challengeText.frame = CGRectMake(5, 50, UIScreen.mainScreen().bounds.size.width - 10, 100)
        self.profilePicture.frame = CGRectMake(5, 5, 45, 45)
        self.pseudo.frame = CGRectMake(60, 10, self.frame.size.width - 60, 20)
        
        self.addTextChallenge()
        self.addImageProfile()
        self.addPseudo()
        
        self.backgroundColor = UIColor(red: 218 / 255.0, green: 223 / 255.0, blue: 225 / 255.0, alpha: 1)
        self.viewContent.backgroundColor = UIColor.whiteColor()
        
        self.viewContent.addSubview(self.challengeText)
        self.viewContent.addSubview(self.profilePicture)
        self.viewContent.addSubview(self.pseudo)
        self.addSubview(self.viewContent)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
