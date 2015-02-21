//
//  PhotoChallengeFormCell.swift
//  Adok
//
//  Created by Remi Robert on 19/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class PhotoChallengeFormCell: UITableViewCell {

    lazy var buttonAddPhoto: UIButton = {
        let buttonAddPhoto = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2 - 25, 25, 50, 50))
        buttonAddPhoto.setImage(UIImage(named: "addPhoto"), forState: UIControlState.Normal)
        buttonAddPhoto.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, 50)
        buttonAddPhoto.layer.cornerRadius = 5
        return buttonAddPhoto
    }()
    
    lazy var imageChallenge: UIImageView = {
        let imageChallenge = UIImageView()
        imageChallenge.frame.origin = CGPointZero
        imageChallenge.frame.size = CGSizeZero
        imageChallenge.layer.masksToBounds = true
        imageChallenge.contentMode = UIViewContentMode.ScaleAspectFill
        imageChallenge.userInteractionEnabled = true
        return imageChallenge
    }()
    
    var imageContent: UIImage! {
        get {
            return nil
        }
        set {
            imageChallenge.frame.size = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 200)
            imageChallenge.image = newValue
        }
    }

    var sizeHeight: CGFloat {
        get {
            return ((imageChallenge.image != nil)) ? 200 : 100
        }
        set {
            
        }
    }
    
    func initContent() {
        self.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(buttonAddPhoto)
        self.contentView.addSubview(imageChallenge)
    }
}
