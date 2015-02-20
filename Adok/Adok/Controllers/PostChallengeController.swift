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
    
    lazy var tableViewFormPost: UITableView = {
        let tableViewFormPost = UITableView(frame: CGRectMake(0, 64,
            UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 64))
        tableViewFormPost.delegate = self
        tableViewFormPost.dataSource = self
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
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
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
        textView.sizeToFit()
        textView.frame.size.width = UIScreen.mainScreen().bounds.size.width - 20
        tableViewFormPost.reloadData()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        
        initCellsForm()
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))

        let navigationItem = UINavigationItem(title: "New challenge")
        
        let exitButton = UIBarButtonItem(image: UIImage(named: "exitForm"), style: UIBarButtonItemStyle.Done, target: self, action: "exitController")
        let postButton = UIBarButtonItem(image: UIImage(named: "post"), style: UIBarButtonItemStyle.Done, target: self, action: "exitController")

        navigationItem.leftBarButtonItem = exitButton
        navigationItem.rightBarButtonItem = postButton
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.pushNavigationItem(navigationItem, animated: false)
        
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
        tableViewFormPost.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2), atScrollPosition: UITableViewScrollPosition.None, animated: true)
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
