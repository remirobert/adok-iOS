//
//  ProgressView.swift
//  Adok
//
//  Created by Remi Robert on 25/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ProgressView: NSObject {
   
    private var isDisplay: Bool!
    private var progressView: MBProgressHUD!
    
    private class var sharedInstance: ProgressView {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ProgressView? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ProgressView()
            Static.instance?.isDisplay = false
            
            Static.instance?.progressView = MBProgressHUD()
            Static.instance?.progressView.frame = UIScreen.mainScreen().bounds
            Static.instance?.progressView.mode = MBProgressHUDModeIndeterminate
            Static.instance?.progressView.color = UIColor(hue:0.62, saturation:0.77, brightness:0.57, alpha:1)
        }
        return Static.instance!
    }
    
    class func displayProgressView(parentView: UIView, textContent: String?) {
        sharedInstance.progressView.removeFromSuperview()
        parentView.addSubview(sharedInstance.progressView)
        sharedInstance.progressView.show(true)
    }
    
    class func hideProgressView() {
        sharedInstance.progressView.hide(true)
    }
}
