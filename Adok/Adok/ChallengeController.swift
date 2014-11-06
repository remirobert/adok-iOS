//
//  ChallengeController.swift
//  HadokNewAnimation
//
//  Created by Remi Robert on 28/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

class ChallengeController: UIViewController, UITableViewDelegate, UITableViewDataSource, PageController {
    
    var challengeTableView: UITableView?
    var challenges: [ChallengeContent]?
    
    var titlePageController: String?
    var imagePageController: UIImage?
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentHeightCell = (self.challenges![indexPath.row] as ChallengeContent).heightContent
        
        return 100
        return (self.challenges![indexPath.row] as ChallengeContent).heightContent
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.challenges!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ChallengeViewCell? = tableView.dequeueReusableCellWithIdentifier("challengeCell") as? ChallengeViewCell

        
        let currentChallenge = self.challenges?[indexPath.row] as ChallengeContent?
        
        cell!.pseudo.text = currentChallenge!.textChallenge
        cell!.profilePicture.image = UIImage(named: "1")
        return cell!
    }
    
    func initChallengeTableView() {
        self.challengeTableView = UITableView(frame: self.view.frame)
        
        self.challengeTableView?.backgroundColor = UIColor.clearColor()
        self.challengeTableView?.registerClass(ChallengeViewCell.self, forCellReuseIdentifier: "challengeCell")
        self.challengeTableView?.delegate = self
        self.challengeTableView?.dataSource = self
        self.challengeTableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.view.addSubview(self.challengeTableView!)
    }
    
    func initContentchallenge() {
        self.challenges = Array()
        
        var textLetterRand = ["new challenge blabla blablablablablablablablablablablablablablablablablablablablablablablablablabla blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla", "fdsfdsfdsfsd fdsf sd fsd fs df sdf sd fd sf ds fds f dsf dsf sd fs fs fs f s fds fds fdsffffdsfdsfdsfds f sdfsdfsdfdssdfdsfsdf", "fdsfdfds fdsfsdfs", "fdsfdsfsdfsddsfsdfsd", "fdsfsf"]
        
        
        for var index = 0; index < 100; index++ {
            let currentChallenge = ChallengeContent(imageProfile: "", textChallenge: "index : \(index)", titleChallenge: "challenge")
            
            self.challenges?.append(currentChallenge)
        }
        self.challengeTableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initChallengeTableView()
        self.initContentchallenge()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
