//
//  ParallaxImage.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ParallaxImage: UIView {

    lazy var imageContent: UIImageView! = {
        let imageContent = UIImageView()
        imageContent.contentMode = UIViewContentMode.ScaleAspectFill
        imageContent.layer.masksToBounds = true
        return imageContent
    }()
    
    var image: UIImage! {
        get {
            return imageContent.image!
        }
        set {
            imageContent.image = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        imageContent.frame = CGRectMake(0, 40, frame.size.width, frame.size.height + 70)
        self.addSubview(imageContent)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
