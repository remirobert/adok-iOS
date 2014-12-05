//
//  RRTransitionViewController.swift
//  Adok-iOS
//
//  Created by Remi Robert on 04/12/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

@objc protocol PageViewController {
    var index: NSNumber! {get set}
    var titlePageController: String! {get set}
    var imagePageController: UIImage! {get set}
}

class RRTransitionViewController: UIViewController, UIScrollViewDelegate,
UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    private var pageViewController: UIPageViewController!
    private var controllers = Array<UIViewController>()
    private var currentController: Int = 0
    private var tabBarScroll: UIScrollView!
    private var currentContentScrollX = 375
    private var scrollNavigationBar: UIScrollView!
    
    private var isScrollingManually = false
    private var animationPageViewFinished = false
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
        previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
            if (completed == true) {
                self.animationPageViewFinished = true
                self.currentController = (self.pageViewController.viewControllers.last as PageViewController).index.integerValue
            }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController
        viewController: UIViewController) -> UIViewController? {
        var index = (viewController as PageViewController).index.integerValue
        if (index - 1 >= 0) {
            //self.currentController = index - 1
            return (self.controllers[index - 1])
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController
        viewController: UIViewController) -> UIViewController? {
        var index = (viewController as PageViewController).index.integerValue
        if (index + 1 < self.controllers.count) {
            //self.currentController = index + 1
            return (self.controllers[index + 1])
        }
        return nil
    }
    
    private func setScrollViewDelegate() {
        for currentView in self.pageViewController.view.subviews {
            if currentView.isKindOfClass(UIScrollView.self) {
                (currentView as UIScrollView).delegate = self
            }
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        println("okay")
        if (self.currentController == 0 && scrollView.contentOffset.x < scrollView.frame.size.width) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0)
        }
        else if (self.currentController == self.controllers.count - 1 && scrollView.contentOffset.x > scrollView.frame.size.width) {
            println("cancel bounce")
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0)
        }
        self.isScrollingManually = false
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.animationPageViewFinished = false
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView) {
        println("finish")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentTotalScrollPageViewController = (scrollView.contentOffset.x - scrollView.frame.size.width) +
            self.view.frame.size.width * CGFloat(self.currentController)

        if (self.isScrollingManually == false && scrollView.contentOffset.x >= 0) {
            println("content : \(Int(scrollView.contentOffset.x))")
            if (self.currentController == 0 && scrollView.contentOffset.x < scrollView.frame.size.width) {
                scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0)
                return
            }
            else if (self.currentController == self.controllers.count - 1 && scrollView.contentOffset.x > scrollView.frame.size.width) {
                scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0)
                return
            }
            if (CGFloat(currentTotalScrollPageViewController) / 2.5 >= 0) {
                self.tabBarScroll.contentOffset = CGPointMake(CGFloat(currentTotalScrollPageViewController) / 2.5, 0)
            }
            self.scrollNavigationBar.contentOffset = CGPointMake(CGFloat(currentTotalScrollPageViewController), 0)
        }
        
    }
    
    func click(sender: AnyObject) {
        var clickedButton = (sender as UIButton)
        
        if (self.currentController != clickedButton.tag) {
            println("current: \(self.currentController) : \(clickedButton.tag) => \((self.controllers[clickedButton.tag]as PageViewController).index.integerValue )")
            self.isScrollingManually = true
            self.pageViewController.setViewControllers([self.controllers[clickedButton.tag]],
                direction: (clickedButton.tag > self.currentController) ? UIPageViewControllerNavigationDirection.Forward : UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: { (completed: Bool) -> Void in
                    //self.isScrollingManually = false
            })
            
            self.scrollNavigationBar.setContentOffset(CGPointMake(self.view.frame.size.width * CGFloat(clickedButton.tag), 0), animated: true)
            self.tabBarScroll.setContentOffset(CGPointMake((self.view.frame.size.width / 2.5) * CGFloat(clickedButton.tag), 0), animated: true)
            
            self.currentController = clickedButton.tag
        }
        //println("\((sender as UIButton).tag)")
    }
    
    private func initScrollBarNavigation() {
        self.tabBarScroll = UIScrollView(frame: CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49))
        self.tabBarScroll.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1)
        var indexPositionX = Float(self.view.frame.size.width / 2.5) + 15
        var indexTag = 0
        
        self.tabBarScroll.canCancelContentTouches = true
        self.tabBarScroll.scrollEnabled = false
        
        for currentController in self.controllers {
            var v = UIButton(frame: CGRectMake(CGFloat(indexPositionX), 0, 49, 49))
            v.backgroundColor = UIColor.grayColor()
            v.tag = indexTag
            v.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.tabBarScroll.addSubview(v)
            indexPositionX += Float(self.view.frame.size.width / 2.5)
            indexTag += 1
        }
        
        self.tabBarScroll.contentSize = CGSizeMake(CGFloat(indexPositionX), 49)
        self.view.addSubview(self.tabBarScroll)
    }
    
    private func initNavigationBar() {
        self.scrollNavigationBar = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width, 74))
        self.scrollNavigationBar.backgroundColor = UIColor.whiteColor()
        
        self.scrollNavigationBar.layer.shadowColor = UIColor.grayColor().CGColor
        self.scrollNavigationBar.layer.shadowOffset = CGSizeMake(0, 2)
        self.scrollNavigationBar.layer.shadowOpacity = 0.7
        self.scrollNavigationBar.layer.shadowRadius = 3
        self.scrollNavigationBar.layer.masksToBounds = false
        
        self.scrollNavigationBar.scrollEnabled = false
        for currentController in self.controllers {
            var currentTitle = UILabel(frame: CGRectMake(CGFloat((currentController as PageViewController).index.integerValue * Int(self.view.frame.size.width)),
                24, self.view.frame.size.width, 54))
            currentTitle.text = (currentController as PageViewController).titlePageController
            currentTitle.textAlignment = NSTextAlignment.Center
            currentTitle.backgroundColor = UIColor(red: 238 / 255.0, green: 238 / 255.0, blue: 238 / 255.0, alpha: 1)
            
            self.scrollNavigationBar.addSubview(currentTitle)
        }
        self.view.addSubview(self.scrollNavigationBar)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll,
            navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        
        self.pageViewController.setViewControllers([self.controllers[1]],
            direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        self.pageViewController.view.frame = self.view.frame
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.initScrollBarNavigation()
        self.setScrollViewDelegate()
        self.initNavigationBar()
    }
    
    init(childController controllers:[UIViewController]) {
        super.init()
        self.controllers = controllers
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIScrollView {
    func touchesShouldCancelInContentView(view: UIView) -> Bool {
        return view.isKindOfClass(UIButton.self)
    }
}
