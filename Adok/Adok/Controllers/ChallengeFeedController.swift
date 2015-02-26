//
//  ChallengeFeedController.swift
//  Adok
//
//  Created by Remi Robert on 09/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

let challengeCellIdentifier = "ChallengeFeedTableViewCell"

class ChallengeFeedController: UITableViewController, UIScrollViewDelegate {

    var challenges: Array<Challenge> = Array()
    var challenge = Challenge()
    var challengeLastItem: String? = nil
    
    lazy var activityLoader: UIActivityIndicatorView! = {
        let activityLoader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityLoader.color = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        return activityLoader
    }()
    
    func fetchChallenges(feedParameter: Feed, completionLoad: (()->())?) {
        Request.launchFeedEventRequest(UserInformation.sharedInstance.informations.access_token,
            parameters: feedParameter, blockSuccess: { (operation, responseFeed, lastItem) -> () in
                NSLog("lastItem : \(lastItem)")
                
                if self.challengeLastItem == nil {
                    self.challenges.removeAll(keepCapacity: false)
                    self.challenges = responseFeed
                }
                else {
                    for currentChallenge in responseFeed {
                        self.challenges.append(currentChallenge)
                    }
                }
                self.challengeLastItem = lastItem
                self.tableView.reloadData()
                completionLoad?()
        }) { (error) -> () in
            println("error get ressource : \(error)")
            completionLoad?()
        }
    }
    
    func refreshContentFeed() {
        let feedParameter = Feed()
        feedParameter.limit = 20

        fetchChallenges(feedParameter, completionLoad: { () -> () in
            self.refreshControl?.endRefreshing()
        })
    }
    
    func addContentFeed() {
        let feedParameter = Feed()
        feedParameter.limit = 20
        feedParameter.last_item = self.challengeLastItem
        
        fetchChallenges(feedParameter, completionLoad: { () -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityLoader.stopAnimating()
            })
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func postNewChallenge() {
        let postController = PostChallengeController()
        postController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        //postController.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        refreshContentFeed()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.layer.masksToBounds = true
        self.refreshControl?.tintColor = UIColor.whiteColor()
        self.refreshControl?.backgroundColor = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        self.refreshControl?.addTarget(self, action: "refreshContentFeed", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
        self.title = "Challenges"
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        self.tableView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        self.tableView.registerClass(ChallengeFeedTableViewCell.self, forCellReuseIdentifier: challengeCellIdentifier)
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
        
        let tempo = Tempo(stringDate: challenges[indexPath.row].start, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    
        cell?.time.text = tempo.timeAgoSimpleNow()
        cell?.loginContent = challenges[indexPath.row].user.full
        cell?.textContent = challenges[indexPath.row].title
        cell?.profilePicutre.sd_setImageWithURL(NSURL(string: challenges[indexPath.row].user.picture))
        cell?.pictureContent.sd_setImageWithURL(NSURL(string: challenges[indexPath.row].picture))
        cell?.isContentPicture = (challenges[indexPath.row].picture != "") ? true : false
        cell?.updateContent()
        return cell!
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(ChallengeFeedTableViewCell.calcHeightContent(challenges[indexPath.row]))
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = DetailChallengeController()
        
        detailController.challenge = challenges[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if challenges.count == 0 {
            return
        }
        let offset = scrollView.contentOffset;
        let bounds = scrollView.bounds;
        let size = scrollView.contentSize;
        let inset = scrollView.contentInset;
        let y = offset.y + bounds.size.height - inset.bottom;
        let h = size.height;
        
        let reload_distance: CGFloat = 20.0;
        if (y > h + reload_distance) {
            activityLoader.frame.origin = CGPointMake(self.view.frame.size.width / 2 - activityLoader.frame.size.width / 2, scrollView.contentSize.height)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityLoader.startAnimating()
            })
            self.tableView.addSubview(activityLoader)
            self.tableView.sendSubviewToBack(activityLoader)
            addContentFeed()
            println("reload more content")
        }
    }
    
}
