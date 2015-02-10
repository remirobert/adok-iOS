//
//  ChallengeFeedController.swift
//  Adok
//
//  Created by Remi Robert on 09/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

let challengeCellIdentifier = "ChallengeFeedTableViewCell"

class ChallengeFeedController: UITableViewController {

    var challenges: Array<Challenge>!
    var challenge = Challenge()
    
    func initchallenges() {
        self.challenges = Array()
        
        let c1 = Challenge()
        c1.login = "remi"
        c1.pictureUrl = nil
        c1.content = "fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd"
        
        let c2 = Challenge()
        c2.login = "remi robert d'apitech bordeaux"
        c2.pictureUrl = nil
        c2.content = "fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsdfdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd"

        let c3 = Challenge()
        c3.login = "remi robert photo"
        c3.pictureUrl = "img"
        c3.content = "fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd"

        let c4 = Challenge()
        c4.login = "remi robert photo bordeaux"
        c4.pictureUrl = "img"
        c4.content = "fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd fsd fdsfdsf dsf dsfds fds fds fds fdsf dsfds fsd"

        
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c1)
        self.challenges.append(c2)
        self.challenges.append(c2)
        self.challenges.append(c4)
        self.challenges.append(c2)
        self.challenges.append(c3)
        self.challenges.append(c1)
        self.challenges.append(c2)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initchallenges()
        self.view.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor(red:0.83, green:0.84, blue:0.86, alpha:1)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        self.tableView.registerClass(ChallengeFeedTableViewCell.self, forCellReuseIdentifier: challengeCellIdentifier)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(ChallengeFeedTableViewCell.calcHeightContent(challenges[indexPath.row]))
        //return 140
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ChallengeFeedTableViewCell? = tableView.dequeueReusableCellWithIdentifier("challengeCell") as? ChallengeFeedTableViewCell
        if (cell == nil) {
            cell = ChallengeFeedTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: challengeCellIdentifier)
            cell?.initContentCell()
        }
        cell?.loginContent = challenges[indexPath.row].login
        cell?.textContent = challenges[indexPath.row].content
        cell?.loginPicture = UIImage(named: "profile")
        if let image = UIImage(named: (challenges[indexPath.row].pictureUrl == nil) ? "" : challenges[indexPath.row].pictureUrl) {
            cell?.imageContent = image
        }
        else {
            cell?.imageContent = nil
        }
        return cell!
    }

}
