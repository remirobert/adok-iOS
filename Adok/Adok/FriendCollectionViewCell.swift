//
//  FriendCollectionViewCell.swift
//  HadokNewAnimation
//
//  Created by Remi Robert on 16/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {

    var imageProfile: UIImageView?
    var profileName: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let randImage = ["https://d13yacurqjgara.cloudfront.net/users/4467/screenshots/483734/basketball.jpg", "https://d13yacurqjgara.cloudfront.net/users/6014/screenshots/513008/monsterball_-_gasssy.jpg", "https://d13yacurqjgara.cloudfront.net/users/4467/screenshots/492585/ogreball.jpg", "https://d13yacurqjgara.cloudfront.net/users/4467/screenshots/492671/monsterball-maurice.jpg", "https://d13yacurqjgara.cloudfront.net/users/4467/screenshots/494825/monsterball-ref.jpg", "https://d13yacurqjgara.cloudfront.net/users/38192/screenshots/496799/bball.jpg"]
        
        
        self.imageProfile = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.width))
        self.imageProfile?.backgroundColor = UIColor.greenColor()
        self.imageProfile?.clipsToBounds = true
        self.imageProfile?.layer.cornerRadius = self.frame.size.width / 2
        
        var value = rand() % Int32(randImage.count)
        
        ImageDownloader.downloadImageWithSize(urlImage: randImage[Int(value)], sizeImage: imageProfile!.frame.size) { (imageDownloaded) -> () in
            self.imageProfile!.image = imageDownloaded
            self.imageProfile!.contentMode = UIViewContentMode.ScaleAspectFill
        }

        
        self.profileName = UILabel(frame: CGRectMake(0, self.frame.size.width, self.frame.size.width, 30))
        self.profileName?.textAlignment = NSTextAlignment.Center
        self.profileName?.text = "Rémi"
        
        self.addSubview(self.profileName!)
        self.addSubview(self.imageProfile!)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
