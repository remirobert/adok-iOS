//
//  ProfileImage.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ProfileImage: UIView {

     private lazy var profileImage: UIImageView! = {
        let profileImage = UIImageView()
        profileImage.contentMode = UIViewContentMode.ScaleAspectFill
        profileImage.layer.masksToBounds = true
        return profileImage
    }()
    
    func setImageProfile(image: UIImage?) {
        if (image != nil) {
            profileImage.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        profileImage.frame.size = CGSizeMake(frame.size.width - 10, frame.size.height - 10)
        profileImage.frame.origin = CGPointMake(5, 5)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        self.layer.cornerRadius = frame.size.width / 2
        self.addSubview(profileImage)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

