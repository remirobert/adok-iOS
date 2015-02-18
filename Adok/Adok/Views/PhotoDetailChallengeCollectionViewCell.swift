//
//  PhotoDetailChallengeCollectionViewCell.swift
//  Adok
//
//  Created by Remi Robert on 18/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class PhotoDetailChallengeCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame.size = frame.size
        imageView.frame.origin = CGPointZero
        self.addSubview(imageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
