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
    
    var currentProfileContent: Me!
    
    func fetchDataProfile() {
        if let currentMe = Me.loadSaved() as Me! {
            currentProfileContent = currentMe
            displayContent()
        }
        else {
            Request.launchMeRequest(UserInformation.sharedInstance.informations.access_token,
                blockSuccess: { (operation, responseMe) -> () in
                    Me.clear()
                    responseMe.save()
                    self.currentProfileContent = responseMe
                    self.displayContent()
                    return
            }, blockFail: { (error) -> () in
                println("return : \(error))")
                return
                // handle error
            })
        }
    }
    
    func displayContent() {
        profileView.profileImage.setImageProfile(UIImage(named: "profile"))
        profileView.labelLogin.text = currentProfileContent.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView = ProfileView()
        fetchDataProfile()
        profileView.profileImage.setImageProfile(UIImage(named: "profile"))
        profileView.labelLogin.text = ""
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.tableHeaderView = profileView
    }

    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        let challenge = Challenge()
        challenge.login = "remi robert"
        challenge.content = "sauter par dessus une barrière sans tomber."
        return CGFloat(ChallengeFeedTableViewCell.calcHeightContent(challenge))
    }
    
}
