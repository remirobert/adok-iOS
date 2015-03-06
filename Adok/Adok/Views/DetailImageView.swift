//
//  DetailImageView.swift
//  Adok
//
//  Created by Remi Robert on 06/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class DetailImageView: UIView {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: UIScreen.mainScreen().bounds)
        image.layer.masksToBounds = true
        image.contentMode = UIViewContentMode.ScaleAspectFit
        return image
    }()

    private class var sharedInstance: DetailImageView {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: DetailImageView? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DetailImageView()
            Static.instance?.frame = UIScreen.mainScreen().bounds
            Static.instance?.alpha = 0
            var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
            visualEffectView.frame = UIScreen.mainScreen().bounds
            
            Static.instance?.addSubview(visualEffectView)
            Static.instance!.imageView.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2,
                UIScreen.mainScreen().bounds.size.height / 2 - 64)
            Static.instance?.addSubview(Static.instance!.imageView)
        }
        return Static.instance!
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            DetailImageView.sharedInstance.alpha = 0
            }) { (anim: Bool) -> Void in
                self.removeFromSuperview()
        }
    }
    
    class func displayDetailImageView(parentView: UIView, image: UIImage) {
        DetailImageView.sharedInstance.frame.origin = CGPointZero
        parentView.addSubview(DetailImageView.sharedInstance)
    }

    class func displayDetailImageView(parentView: UIView, imageUrl: String) {
        DetailImageView.sharedInstance.frame.origin = CGPointZero
        parentView.addSubview(DetailImageView.sharedInstance)
        
        DetailImageView.sharedInstance.imageView.sd_setImageWithURL(NSURL(string: imageUrl))
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            DetailImageView.sharedInstance.alpha = 1
        })
    }
}
