//
//  PhotosController.swift
//  Adok
//
//  Created by Remi Robert on 10/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class PhotosController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let collectionPhotoLayout = UICollectionViewFlowLayout()
    var photosChallenges: Array<ChallengeGallery> = Array()

    lazy var photoCollection: UICollectionView = {
        self.collectionPhotoLayout.minimumLineSpacing = 0
        self.collectionPhotoLayout.minimumInteritemSpacing = 0
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

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosChallenges.count
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.addSubview(photoCollection)
        
        if let user = Me.loadSaved() {
            Request.launchNewGalleryUserRequest(UserInformation.sharedInstance.informations.access_token,
                idUser: user.id, blockSuccess: { (operation, responseGallery) -> () in
                    if responseGallery != nil {
                        self.photosChallenges = responseGallery!
                        self.photoCollection.reloadData()
                    }
                }) { (error) -> () in
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
