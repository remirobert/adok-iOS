//
//  TransitionViewController.swift
//  HadokNewAnimation
//
//  Created by Remi Robert on 10/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

@objc protocol PageController {
    var titlePageController: String? {get set}
    var imagePageController: UIImage? {get set}
}

class TransitionViewController: UIViewController, UIScrollViewDelegate {
    private var controllers: [UIViewController]?
    private var titlePageScroll: UIScrollView
    private var scrollMenuNavigation: UIScrollView
    private var pageScroll: UIScrollView
    var startController: Int = 0
    private var titlePageController = ["Friends", "Challenge", "Vote"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 218 / 255.0, green: 223 / 255.0, blue: 225 / 255.0, alpha: 1)
        self.initPageScrollNavigation()
        self.initScrollMenuNavigation()
        self.pageScroll.contentOffset = CGPointMake(CGFloat(CGFloat(self.startController) *
            UIScreen.mainScreen().bounds.size.width), 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "presentController", name: "presentController", object: nil)
    }
    
    func presentController() {
        self.presentViewController(DetailFriendController(), animated: true, completion: nil)
    }
    
    func animScroll() {
        for var index: Int = 0; index < self.scrollMenuNavigation.subviews.count; index++ {
            if index == self.startController {
                (self.scrollMenuNavigation.subviews[index] as UIImageView).layer.runAnimation(Animation.bounce(15, delay: 0.1))
                return Void()
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.startController = Int(self.pageScroll.contentOffset.x / UIScreen.mainScreen().bounds.size.width)
        self.animScroll()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.startController = Int(self.pageScroll.contentOffset.x / UIScreen.mainScreen().bounds.size.width)
        self.animScroll()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.scrollMenuNavigation.contentOffset = CGPointMake(self.pageScroll.contentOffset.x / 2.5,
            self.pageScroll.contentOffset.y)
        self.titlePageScroll.contentOffset = self.pageScroll.contentOffset
    }
    
    func touchMenuScroll(tapRecognizer: UITapGestureRecognizer) {
        let postiontouch = tapRecognizer.locationInView(self.view)

        switch postiontouch.x {
        case let currentPos where currentPos < UIScreen.mainScreen().bounds.size.width / 3:
            if self.startController > 0 {
                if ((self.controllers![self.startController - 1] as PageController).titlePageController == nil &&
                    (self.controllers![self.startController - 1] as PageController).imagePageController == nil) {
                    return Void()
                }
                self.pageScroll.setContentOffset(CGPointMake(UIScreen.mainScreen().bounds.size.width *
                    CGFloat(self.startController - 1), 0), animated: true)
            }
        case let currentPos where currentPos >= (UIScreen.mainScreen().bounds.size.width / 3) * 2:
            if self.startController < self.controllers!.count - 1 {
                if ((self.controllers![self.startController + 1] as PageController).titlePageController == nil &&
                    (self.controllers![self.startController + 1] as PageController).imagePageController == nil) {
                        return Void()
                }
                self.pageScroll.setContentOffset(CGPointMake(UIScreen.mainScreen().bounds.size.width *
                    CGFloat(self.startController + 1), 0), animated: true)
            }
        default: Void()
        }
    }
    
    func initScrollMenuNavigation() {
        self.scrollMenuNavigation = UIScrollView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 50,
            UIScreen.mainScreen().bounds.size.width, 50))
        
        self.scrollMenuNavigation.backgroundColor = UIColor(red: 85 / 255.0, green: 85 / 255.0, blue: 85 / 255.0, alpha: 1)//UIColor(red: 69 / 255.0, green: 105 / 255.0, blue: 251 / 255.0, alpha: 1)
        self.scrollMenuNavigation.scrollEnabled = false

        var currentIndexOffsetX: Float = 0

        for currentPage in self.controllers! {
            var controller = ((currentPage as UIViewController) as PageController)

            if controller.imagePageController != nil {
                let imageView = UIImageView(frame: CGRectMake(CGFloat(currentIndexOffsetX), 15,
                    UIScreen.mainScreen().bounds.size.width, 30))
                imageView.image = controller.imagePageController
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                imageView.exclusiveTouch = false
                self.scrollMenuNavigation.addSubview(imageView)
            }
            if controller.titlePageController != nil {
                let labelTitle = UILabel(frame: CGRectMake(CGFloat(currentIndexOffsetX), 20,
                    UIScreen.mainScreen().bounds.size.width, 44))
                if (controller.imagePageController != nil) {
                    labelTitle.font = UIFont(name: labelTitle.font.fontName, size: 10)
                    labelTitle.frame = CGRectMake(labelTitle.frame.origin.x, 54, labelTitle.frame.size.width, 10)
                }
                labelTitle.textAlignment = NSTextAlignment.Center
                labelTitle.text = controller.titlePageController
                labelTitle.exclusiveTouch = false
                self.scrollMenuNavigation.addSubview(labelTitle)
            }
            currentIndexOffsetX += Float(UIScreen.mainScreen().bounds.size.width / 2.5)
        }
        self.scrollMenuNavigation.contentSize = CGSizeMake(CGFloat(currentIndexOffsetX), 64)
        let gestureTapMenu = UITapGestureRecognizer(target: self, action: "touchMenuScroll:")
        self.scrollMenuNavigation.addGestureRecognizer(gestureTapMenu)
        self.view.addSubview(self.scrollMenuNavigation)
    }
    
    func initPageScrollNavigation() {
        self.pageScroll.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height - 104)
        self.pageScroll.showsVerticalScrollIndicator = false
        self.pageScroll.showsHorizontalScrollIndicator = false
        self.pageScroll.pagingEnabled = true
        self.pageScroll.bounces = false
        self.pageScroll.delegate = self
        
        var currentIndexOffsetX: Float = 0
        
        for currentPage in self.controllers! {
            var controller = (currentPage as UIViewController)
            
            let newFrame = CGRectMake(CGFloat(currentIndexOffsetX), 0, controller.view.frame.size.width,
                controller.view.frame.size.height - 94)
            controller.view.frame = newFrame
            self.pageScroll.addSubview((currentPage as UIViewController).view)
            currentIndexOffsetX += Float(UIScreen.mainScreen().bounds.size.width)
        }
        self.pageScroll.contentSize = CGSizeMake(CGFloat(currentIndexOffsetX), self.pageScroll.frame.size.height)
        self.view.addSubview(self.pageScroll)
        self.initTitlePageScroll()
    }
    
    func initTitlePageScroll() {
        self.titlePageScroll.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 64)
        
        self.titlePageScroll.scrollEnabled = false
        self.titlePageScroll.backgroundColor = UIColor(red: 85 / 255.0, green: 85 / 255.0, blue: 85 / 255.0, alpha: 1)//UIColor(red: 69 / 255.0, green: 105 / 255.0, blue: 251 / 255.0, alpha: 1)
        self.view.addSubview(self.titlePageScroll)
        var indexPositionX: CGFloat = 0
        
        for currentTitle in self.titlePageController {
            var titleView = UILabel(frame: CGRectMake(indexPositionX, 22, UIScreen.mainScreen().bounds.size.width, 44))
            titleView.text = currentTitle
            titleView.contentMode = UIViewContentMode.Center
            titleView.textAlignment = NSTextAlignment.Center
            titleView.textColor = UIColor.whiteColor()
            titleView.font = UIFont(name: "Jaapokki-Regular", size: 20)
            self.titlePageScroll.addSubview(titleView)
            indexPositionX += UIScreen.mainScreen().bounds.size.width
        }
        self.titlePageScroll.contentOffset = CGPointMake(UIScreen.mainScreen().bounds.size.width, 0)
        self.titlePageScroll.contentSize = CGSizeMake(indexPositionX, self.titlePageScroll.frame.size.height)
    }
    
    override init() {
        self.scrollMenuNavigation = UIScrollView()
        self.titlePageScroll = UIScrollView()
        self.pageScroll = UIScrollView()
        super.init()
    }
    
    init(controllersParam: [UIViewController]) {
        self.scrollMenuNavigation = UIScrollView()
        self.pageScroll = UIScrollView()
        self.titlePageScroll = UIScrollView()
        super.init()
        self.controllers = controllersParam
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.pageScroll = UIScrollView()
        self.titlePageScroll = UIScrollView()
        self.scrollMenuNavigation = UIScrollView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
