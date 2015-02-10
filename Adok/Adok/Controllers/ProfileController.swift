//
//  ProfileController.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    var pageMenu: CAPSPageMenu?
    
    lazy var controllers: Array<UIViewController>! = {
        let controllerBadge = BadgeController()
        controllerBadge.title = "BADGE"
        let photosController = PhotosController()
        photosController.title = "PHOTOS"
        let challengeFluxController = ChallengeFluxController()
        challengeFluxController.title = "CHALLENGES"
        return [challengeFluxController, controllerBadge, photosController]
    }()
    
    lazy var profileView: ProfileView! = {
        let profileView = ProfileView()
        return profileView
    }()
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.profileImage.setImageProfile(UIImage(named: "profile"))
        self.view.addSubview(profileView)
        
        var parameters: [String: AnyObject] = ["scrollMenuBackgroundColor": UIColor(red:0.35, green:0.48, blue:0.97, alpha:1),
            "viewBackgroundColor": UIColor(red:0.83, green:0.84, blue:0.86, alpha:1),
            "selectionIndicatorColor": UIColor.whiteColor(),
            "bottomMenuHairlineColor": UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0),
            "menuItemFont": UIFont(name: "HelveticaNeue", size: 13.0)!,
            "menuHeight": 40.0,
            "menuItemWidth": 90.0,
            "centerMenuItems": true]
        
        pageMenu = CAPSPageMenu(viewControllers: controllers, frame: CGRectMake(0.0, profileView.frame.origin.y + profileView.frame.size.height, self.view.frame.width, self.view.frame.height - profileView.frame.size.height), options: parameters)
        self.view.addSubview(pageMenu!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
