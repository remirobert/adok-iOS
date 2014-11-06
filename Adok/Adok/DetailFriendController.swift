//
//  DetailFriendController.swift
//  HadokNewAnimation
//
//  Created by Remi Robert on 13/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class DetailFriendController: UIViewController {

    var pseudoProfile: String?
    var photoProfile: UIImage?
    
    func initBarNavigation() {
        let barNavigation = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 64))
        barNavigation.backgroundColor = UIColor(red: 69 / 255.0, green: 105 / 255.0, blue: 251 / 255.0, alpha: 1)
        
        let pseudo = UILabel(frame: CGRectMake(0, 0, barNavigation.frame.size.width, 64))
        pseudo.textColor = UIColor.whiteColor()
        pseudo.text = pseudoProfile
        
        barNavigation.addSubview(pseudo)
        self.view.addSubview(barNavigation)
    }
    
    func done() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        
        let button = UIButton(frame: CGRectMake(0, 100, 50, 50))
        button.setTitle("ok", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "done", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
        initBarNavigation()
    }

}
