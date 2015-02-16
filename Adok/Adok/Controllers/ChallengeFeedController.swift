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

    //buttonAdd animation
    var buttonAdd: ButtonAdd!
    var sensScrollTableView: Int = 0
    var previousScrollTableView: CGFloat = 0.0
    var isScrollDraging: Bool = false
    var animationFollow:Int = 0
    var currentScrollIncrement: CGFloat = 0.0
    var positionAnimationFollow: CGFloat!
    
    lazy var activityLoader: UIActivityIndicatorView! = {
        let activityLoader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityLoader.color = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        return activityLoader
    }()
    
    func fetchChallenges(feedParameter: Feed, completionLoad: (()->())?) {
        Request.launchFeedEventRequest(UserInformation.sharedInstance.informations.access_token,
            parameters: feedParameter, blockSuccess: { (operation, responseFeed) -> () in
                println("operation success : \(operation)")
                println("response feed : \(responseFeed)")
                
                if feedParameter.last_item == nil {
                    self.challenges.removeAll(keepCapacity: false)
                    self.challenges = responseFeed
                }
                else {
                    for currentChallenge in responseFeed {
                        self.challenges.append(currentChallenge)
                    }
                }
                self.tableView.reloadData()
                completionLoad?()
        }) { (error) -> () in
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
        feedParameter.last_item = challenges.last?.date
        
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
        
        buttonAdd = ButtonAdd(frame: CGRectMake(self.view.frame.size.width / 2 - 35, self.view.frame.size.height - 210, 70, 70))
        self.tableView.addSubview(buttonAdd)
        self.tableView.bringSubviewToFront(buttonAdd)
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
        
        cell?.loginContent = challenges[indexPath.row].user.full
        cell?.textContent = challenges[indexPath.row].title
        
        cell?.loginPicture = UIImage(named: "profile")
        return cell!
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(ChallengeFeedTableViewCell.calcHeightContent(challenges[indexPath.row]))
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if positionAnimationFollow == nil || scrollView.bounds.origin.y < 10 {
            positionAnimationFollow = scrollView.bounds.origin.y + self.view.frame.size.height - 140
        }
        
        if animationFollow == 0 {
            UIView.animateWithDuration((positionAnimationFollow == scrollView.bounds.origin.y + self.view.frame.size.height + 50) ? 0.2 : 0.4, delay: 0, usingSpringWithDamping: 1,
                initialSpringVelocity: 0, options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                    self.buttonAdd.frame.origin.y = self.positionAnimationFollow
                }, completion: nil)
            animationFollow += 1
        }
        else {
            animationFollow += 1
            if animationFollow == 3 {
                animationFollow = 0
            }
        }
        
        if previousScrollTableView < scrollView.contentOffset.y {
            positionAnimationFollow = scrollView.bounds.origin.y + self.view.frame.size.height + 50
            sensScrollTableView = 0
        }
        else {
            positionAnimationFollow = scrollView.bounds.origin.y + self.view.frame.size.height - 140
            currentScrollIncrement = 0
            sensScrollTableView = 1
        }
        previousScrollTableView = scrollView.contentOffset.y
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isScrollDraging = true
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isScrollDraging = false
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
