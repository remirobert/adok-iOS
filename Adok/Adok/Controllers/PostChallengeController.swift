//
//  PostChallengeController.swift
//  Adok
//
//  Created by Remi Robert on 16/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class PostChallengeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {

    var formsCell: Array<UITableViewCell>!
    var heightKeyboard: CGFloat!
    var currentSectionEditing = 0
    var postButton: UIBarButtonItem!
    var navigationItemBar: UINavigationItem!
    var exitButton: UIBarButtonItem!
    var navigationBar: UINavigationBar!
    
    lazy var tableViewFormPost: UITableView = {
        let tableViewFormPost = UITableView(frame: CGRectMake(0, 64,
            UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 64))
        tableViewFormPost.delegate = self
        tableViewFormPost.dataSource = self
        tableViewFormPost.separatorStyle = UITableViewCellSeparatorStyle.None
        tableViewFormPost.backgroundColor = UIColor.clearColor()
        let headerSeparator = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 30))
        tableViewFormPost.tableHeaderView = headerSeparator
        return tableViewFormPost
    }()
    
    lazy var actionTakePhoto: UIActionSheet = {
        let actionSheet = UIActionSheet(title: "Choose a picture", delegate: self, cancelButtonTitle: "Cancel",
            destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Librairy")
        return actionSheet
    }()
    
    lazy var imageLibrairyController: UIImagePickerController = {
        let imageLibrairyController = UIImagePickerController()
        imageLibrairyController.delegate = self
        imageLibrairyController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imageLibrairyController.allowsEditing = false
        return imageLibrairyController
    }()
    
    func textViewDidBeginEditing(textView: UITextView) {
        currentSectionEditing = (textView.tag == 1) ? 0 : 2
        tableViewFormPost.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: currentSectionEditing),
            atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.view.endEditing(true)
        }
        
        var lenContent = 0
        switch textView.tag {
        case 1: lenContent = 60
        case 2: lenContent = 300
        default: lenContent = 0
        }
        if count(textView.text) + count(text) > lenContent {
            return false
        }
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.tag == 1 && strlen(textView.text) > 0 {
            navigationItemBar.rightBarButtonItem = postButton
        }
        else if (textView.tag == 1 && strlen(textView.text) == 0) {
            navigationItemBar.rightBarButtonItem = nil
        }
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.pushNavigationItem(navigationItemBar, animated: false)
        textView.sizeToFit()
        textView.frame.size.width = UIScreen.mainScreen().bounds.size.width - 20
        tableViewFormPost.beginUpdates()
        tableViewFormPost.endUpdates()
        tableViewFormPost.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: currentSectionEditing),
            atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func initCellsForm() {
        formsCell = Array()
        
        let titleChallenge = TitleChallengeForm()
        titleChallenge.initContent()
        titleChallenge.textViewContent.delegate = self
        
        let photoChallenge = PhotoChallengeFormCell()
        photoChallenge.initContent()
        photoChallenge.buttonAddPhoto.addTarget(self, action: "getPhoto", forControlEvents: UIControlEvents.TouchUpInside)
        
        let gestureTap = UIGestureRecognizer(target: self, action: "getPhoto")
        photoChallenge.imageChallenge.addGestureRecognizer(gestureTap)
        
        let descChallenge = DescChallengeFormCell()
        descChallenge.initContent()
        descChallenge.textViewContent.delegate = self
        
        formsCell.append(titleChallenge)
        formsCell.append(photoChallenge)
        formsCell.append(descChallenge)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        self.dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        (self.formsCell[1] as! PhotoChallengeFormCell).imageContent = image
        self.tableViewFormPost.reloadData()
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            imageLibrairyController.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imageLibrairyController, animated: true, completion: nil)
        case 2:
            imageLibrairyController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imageLibrairyController, animated: true, completion: nil)
        default: return
        }
    }
    
    func getPhoto() {
        actionTakePhoto.showInView(self.view)
    }
    
    func exitController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postNewChallenge() {
        let newChallenge = NewChallenge()
        newChallenge.title = (self.formsCell[0] as! TitleChallengeForm).textViewContent.text
        newChallenge.desc = (self.formsCell[2] as! DescChallengeFormCell).textViewContent.text
        newChallenge.file = (self.formsCell[1] as! PhotoChallengeFormCell).imageChallenge.image
        newChallenge.hashtag = ["nil", "nil"]
        
        let tagController = RRTagController()
        tagController.challenge = newChallenge
        
        
        Request.launchNewEventRequest(UserInformation.sharedInstance.informations.access_token, parameters: newChallenge, blockSuccess: { (operation, responseChallenge) -> () in
            NSNotificationCenter.defaultCenter().postNotificationName("hideLoad", object: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
            println("success post event")
            }, blockFail: { (error) -> () in
                NSNotificationCenter.defaultCenter().postNotificationName("hideLoad", object: nil)
                println("fail post event")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        
        initCellsForm()
        navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))

        navigationItemBar = UINavigationItem(title: "New challenge")
        
        exitButton = UIBarButtonItem(image: UIImage(named: "exitForm"), style: UIBarButtonItemStyle.Done, target: self, action: "exitController")
        postButton = UIBarButtonItem(image: UIImage(named: "post"), style: UIBarButtonItemStyle.Done, target: self, action: "postNewChallenge")

        navigationItemBar.leftBarButtonItem = exitButton
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.pushNavigationItem(navigationItemBar, animated: false)
    
        self.view.addSubview(navigationBar)
        self.view.addSubview(tableViewFormPost)
        tableViewFormPost.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }

    func keyboardWillShow(notification: NSNotification) {
        // TODO: change value
        
        if let userInfo = notification.userInfo,
        let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            heightKeyboard = keyboardSize.height
        }
        else {
            heightKeyboard = 0
        }
        tableViewFormPost.contentInset = UIEdgeInsetsMake(0, 0, heightKeyboard, 0)
        let cell = tableViewFormPost.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2))
    }
    
    func keyboardWillHide(notification: NSNotification) {
        heightKeyboard = 0
        tableViewFormPost.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return formsCell.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return formsCell[indexPath.section]
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 20))
        footerView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        let border = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 3))
        border.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1)
        let border2 = UIView(frame: CGRectMake(0, 0, 17, 3))
        border2.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1)

        footerView.addSubview(border)
        footerView.addSubview(border2)
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0: return (formsCell[indexPath.section] as! TitleChallengeForm).sizeHeight
        case 1: return (formsCell[indexPath.section] as! PhotoChallengeFormCell).sizeHeight
        case 2: return (formsCell[indexPath.section] as! DescChallengeFormCell).sizeHeight
        default: return 0
        }
    }
}
