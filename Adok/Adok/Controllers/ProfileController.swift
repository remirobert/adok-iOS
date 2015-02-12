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
        println("fetch")
        if let currentMe = Me.loadSaved() as Me! {
            println("ok")
            currentProfileContent = currentMe
            displayContent()
        }
        else {
            Request.meRequest(UserInformation.sharedInstance.informations.access_token, blockSuccess: { (operation, responseMe) -> () in
                Me.clear()
                println("request sucess")
                responseMe.save()
                self.currentProfileContent = responseMe
                self.displayContent()
                return
                }, blockFail: { (error) -> () in
                    println("error : \(error)")
                    let token = NSUserDefaults.standardUserDefaults().stringForKey("signupToken")
                    let login = Login()
                    login.grant_type = "adok"
                    
                    Request.loginRequest(login, token: token!, blockSuccess: { (operation, responseLogin) -> () in
                        println("ok")
                        self.fetchDataProfile()
//                        responseLogin.save()
//                        UserInformation.sharedInstance.informations = responseLogin
//                        self.currentProfileContent = response
//                        self.displayContent()
                    }, blockFail: { (error) -> () in
                        println("error : \(error)")
                    })
                //handle error network
            })
        }
    }
    
    func displayContent() {
        println("fetch data")
        profileView.profileImage.setImageProfile(UIImage(named: "profile"))
        profileView.labelLogin.text = currentProfileContent.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView = ProfileView()
        fetchDataProfile()
        profileView.profileImage.setImageProfile(UIImage(named: "profile"))
        profileView.labelLogin.text = ""
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
        var cell = tableView.dequeueReusableCellWithIdentifier(challengeProfileViewCellIdentifer) as? ChallengeProfileViewCell
        
        if (cell == nil) {
            cell = ChallengeProfileViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: challengeProfileViewCellIdentifer)
            cell?.initContentCell()
        }
        cell?.imageProfile = UIImage(named: "profile")
        cell?.loginString = "remi robert"
        cell?.contentString = "sauter par dessus une barrière sans tomber."
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let challenge = Challenge()
        challenge.login = "remi robert"
        challenge.content = "sauter par dessus une barrière sans tomber."
        return CGFloat(ChallengeProfileViewCell.calcHeightContent(challenge))
    }
    
}
