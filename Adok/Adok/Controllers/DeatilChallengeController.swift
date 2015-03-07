//
//  DeatilChallengeController.swift
//  Adok
//
//  Created by Remi Robert on 18/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit
import Social

class DetailChallengeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var refreshControl: UIRefreshControl!
    var challenge: Challenge!
    var photosChallenges: Array<ChallengeGallery>!
    let collectionPhotoLayout = UICollectionViewFlowLayout()
    
    lazy var photoCollection: UICollectionView = {
        self.collectionPhotoLayout.minimumLineSpacing = 0
        self.collectionPhotoLayout.minimumInteritemSpacing = 0
        self.collectionPhotoLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 200)
        self.collectionPhotoLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width / 4, UIScreen.mainScreen().bounds.size.width / 4)
        let photoCollection = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 64), collectionViewLayout: self.collectionPhotoLayout)

        photoCollection.registerClass(PhotoDetailChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "photoChallengeCell")
        photoCollection.registerClass(HeaderDetailChallengeView.self,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerChallenge")
        
        photoCollection.backgroundColor = UIColor.clearColor()
        photoCollection.delegate = self
        photoCollection.dataSource = self
        return photoCollection
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
    
    func shareResult(result: SLComposeViewControllerResult) {
        println("result : \(result)")
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        self.dismissViewControllerAnimated(true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage

        Upload.uploadImage(image, url: "\(BASE_URL)events/\(challenge._id)/join",
            token: UserInformation.sharedInstance.informations.access_token, httpMethod: "POST", blockCompletion: { () -> () in
            println("image uploaded")
        }) { (error) -> () in
            AlertView.displayAlertView(self.view, title: "Erreur de connection internet", message: "Impossible d'uploader l'image.")
            println("Error upload image")
        }
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
    
    func shareChallenge() {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let shareController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            shareController.setInitialText("new challenge shared on facebook")
            shareController.completionHandler = shareResult
            self.presentViewController(shareController, animated: true, completion: nil)
        }
    }
    
    func takePhoto() {
        actionTakePhoto.showInView(self.view)
    }
    
    func refreshContentDetail() {
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosChallenges = Array()
        
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.addSubview(photoCollection)
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "shareChallenge")
        
        self.navigationItem.rightBarButtonItems = [shareButton]
        
        refreshControl = UIRefreshControl()
        refreshControl?.layer.masksToBounds = true
        refreshControl?.tintColor = UIColor.whiteColor()
        refreshControl?.backgroundColor = UIColor(red:0.18, green:0.27, blue:0.55, alpha:1)
        refreshControl?.addTarget(self, action: "refreshContentDetail", forControlEvents: UIControlEvents.ValueChanged)
        photoCollection.addSubview(self.refreshControl!)
    }
    
    override func viewDidAppear(animated: Bool) {
        Request.launchNewGalleryChallengeRequest(UserInformation.sharedInstance.informations.access_token,
            idChallenge: challenge._id, blockSuccess: { (operation, responseGallery) -> () in
                if responseGallery != nil {
                    self.photosChallenges = Array()
                    self.photosChallenges = responseGallery
                    self.photoCollection.reloadData()
                }
            }) { (error) -> () in
                AlertView.displayAlertView(self.view, title: "Erreur de connection internet", message: "Impossible de charger la gallerie.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosChallenges.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        DetailImageView.displayDetailImageView(self.view, imageUrl: photosChallenges[indexPath.row].minified)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: PhotoDetailChallengeCollectionViewCell? = collectionView.dequeueReusableCellWithReuseIdentifier("photoChallengeCell",
            forIndexPath: indexPath) as? PhotoDetailChallengeCollectionViewCell
        cell?.imageView.sd_setImageWithURL(NSURL(string: self.photosChallenges[indexPath.row].minified))
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            println("kind view spully : \(kind)")
            var headerView: HeaderDetailChallengeView?
            if (kind == UICollectionElementKindSectionHeader) {
                headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,
                    withReuseIdentifier: "headerChallenge", forIndexPath: indexPath) as? HeaderDetailChallengeView
                headerView?.initContent(challenge)
                headerView?.buttonTakePhoto.addTarget(self, action: "takePhoto", forControlEvents: UIControlEvents.TouchUpInside)
                headerView?.backgroundColor = UIColor.whiteColor()
                self.collectionPhotoLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, headerView!.heightContent!)
            }
            return headerView!
    }
}
