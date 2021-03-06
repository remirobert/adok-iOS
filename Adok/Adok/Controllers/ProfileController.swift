//
//  ProfileController.swift
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ProfileController: UITableViewController {

    var profileView: ProfileView!
    //var refreshControl: UIRefreshControl!
    
    var currentProfileContent: Me!
    
    func launchProfileRequest(completion:(()->())?) {
        
        if let infoUser = UserInformation.sharedInstance.informations {
            Request.launchMeRequest(infoUser.access_token,
                blockSuccess: { (operation, responseMe) -> () in
                    Me.clear()
                    responseMe.save()
                    self.currentProfileContent = responseMe
                    self.displayContent()
                    completion?()
                    return
                }, blockFail: { (error) -> () in
                    println("return : \(error))")
                    completion?()
                    return
                    // handle error
            })
        }
    }
    
    func fetchDataProfile() {
        if let currentMe = Me.loadSaved() {
            currentProfileContent = currentMe
            displayContent()
            return
        }
        else {
            launchProfileRequest(nil)
        }
    }
    
    func refreshProfileContent() {
        launchProfileRequest { () -> () in
            self.refreshControl?.endRefreshing()
        }
    }
    
    func displayContent() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.profileView.profileImage.profileImage.sd_setImageWithURL(NSURL(string: self.currentProfileContent.picture))
//            self.profileView.profileImage.setImageProfile(UIImage(named: "profile"))
            self.profileView.labelLogin.text = self.currentProfileContent.name
            self.profileView.initLabelsStat(self.currentProfileContent)
        })
    }
    
    func galleryUser() {
        println("my gallery")
        
        self.navigationController?.pushViewController(PhotosController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mon profile"
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.layer.masksToBounds = true
        self.refreshControl?.tintColor = UIColor(red:0.97, green:0.13, blue:0.41, alpha:1)
        self.refreshControl?.backgroundColor = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        self.refreshControl?.addTarget(self, action: "refreshProfileContent", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
        profileView = ProfileView()
        profileView.buttonPhoto.addTarget(self, action: "galleryUser", forControlEvents: UIControlEvents.TouchUpInside)
        fetchDataProfile()
        profileView.labelLogin.text = ""
        //self.tableView.backgroundColor = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.tableHeaderView = profileView
        currentProfileContent = Me.loadSaved()
        if currentProfileContent == nil {
            refreshProfileContent()
        }
        else {
            displayContent()
        }
        self.tableView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
    }

    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(challengeProfileViewCellIdentifer) as? ChallengeFeedTableViewCell
        
        if (cell == nil) {
            cell = ChallengeFeedTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: challengeProfileViewCellIdentifer)
            cell?.initContentCell()
        }
        cell?.loginContent = "Rémi robert"
        cell?.textContent = "Blabla"
        cell?.loginPicture = UIImage(named: "profile")
        cell?.pictureContent = nil
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let challenge = Challenge()
//        challenge.login = "remi robert"
//        challenge.content = "sauter par dessus une barrière sans tomber."
//        return CGFloat(ChallengeFeedTableViewCell.calcHeightContent(challenge))
        return 100
    }
    
}
