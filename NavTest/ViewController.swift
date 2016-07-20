//
//  ViewController.swift
//  NavTest
//
//  Created by Scott Jones on 1/5/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var topButton:UIButton?
    @IBOutlet var bottomButton:UIButton?
    @IBOutlet var leftButton:UIButton?
    @IBOutlet var rightButton:UIButton?
    @IBOutlet var buttonContainer:UIView?
    @IBOutlet var pushButton:UIButton?
    @IBOutlet var popButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topButton?.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
        bottomButton?.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
        leftButton?.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
        rightButton?.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
       
        topButton?.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        bottomButton?.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        leftButton?.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        rightButton?.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        topButton?.setTitle("Vertical", forState: .Normal)
        bottomButton?.setTitle("Horizontal", forState: .Normal)
        leftButton?.setTitle("Fade", forState: .Normal)
        rightButton?.setTitle("Shrink", forState: .Normal)
        buttonContainer?.backgroundColor = UIColor.grayColor()
    }
 
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addHandlers()
        updateButtons()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeHandlers()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
 
    func addHandlers() {
        topButton?.addTarget(self, action: #selector(topHit), forControlEvents: .TouchUpInside)
        bottomButton?.addTarget(self, action: #selector(bottomHit), forControlEvents: .TouchUpInside)
        rightButton?.addTarget(self, action: #selector(rightHit), forControlEvents: .TouchUpInside)
        leftButton?.addTarget(self, action: #selector(leftHit), forControlEvents: .TouchUpInside)
    }
    func removeHandlers() {
        topButton?.removeTarget(self, action: #selector(topHit), forControlEvents: .TouchUpInside)
        bottomButton?.removeTarget(self, action: #selector(bottomHit), forControlEvents: .TouchUpInside)
        rightButton?.removeTarget(self, action: #selector(rightHit), forControlEvents: .TouchUpInside)
        leftButton?.removeTarget(self, action: #selector(leftHit), forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var gestureNavigationController:NavigationViewController? {
        return self.navigationController as? NavigationViewController
    }
  
    func topHit() {
        gestureNavigationController?.changeGestureForType(.Vertical)
        updateButtons()
    }
    
    func bottomHit() {
        gestureNavigationController?.changeGestureForType(.Horizontal)
        updateButtons()
    }
    
    func rightHit() {
        gestureNavigationController?.changeGestureForType(.Shrink)
        updateButtons()
    }
    
    func leftHit() {
        gestureNavigationController?.changeGestureForType(.Fade)
        updateButtons()
    }
    
    func getPushAnimator()->UIViewControllerAnimatedTransitioning? {
        if let gn = self.gestureNavigationController {
            switch gn.animationType {
            case .Vertical:
                return PushBottomAnimator()
            case .Horizontal:
                return PushLeftAnimator()
            case .Fade:
                return PushFadeAnimator()
            case .Shrink:
                return PushShrinkAnimator()
            }
        }
        return nil
    }
    
    func getPopAnimator()->UIViewControllerAnimatedTransitioning? {
        if let gn = self.gestureNavigationController {
            switch gn.animationType {
            case .Vertical:
                return PopTopAnimator()
            case .Horizontal:
                return PopRightAnimator()
            case .Fade:
                return PopFadeAnimator()
            case .Shrink:
                return PopShrinkAnimator()
            }
        }
        return nil
    }
    
    func enableButtons() {
    }
    
    func updateButtons() {
        topButton?.enabled = true
        bottomButton?.enabled = true
        leftButton?.enabled = true
        rightButton?.enabled = true
        if let gn = self.gestureNavigationController {
            switch gn.animationType {
            case .Vertical:
                topButton?.enabled = false
            case .Horizontal:
                bottomButton?.enabled = false
            case .Fade:
                leftButton?.enabled = false
            case .Shrink:
                rightButton?.enabled = false
            }
        }
    }
    
}



class ViewControllerPush: ViewController {
    @IBAction func push() {
        performSeguePush()
    }
}
extension ViewControllerPush : CYNavigationPush {
    var seguePush:String {
        return "firstViewControllerPush"
    }
    var pushAnimator:UIViewControllerAnimatedTransitioning? { return self.getPushAnimator() }
}



class ViewControllerPushPop: ViewController {
    @IBAction func push() {
        performSeguePush()
    }
    @IBAction func pop() {
        performSeguePop()
    }
}
extension ViewControllerPushPop : CYNavigationPush {
    var seguePush:String {
        return "viewControllerPush"
    }
    var pushAnimator:UIViewControllerAnimatedTransitioning? { return self.getPushAnimator() }
}
extension ViewControllerPushPop : CYNavigationPop {
    var popAnimator:UIViewControllerAnimatedTransitioning? { return self.getPopAnimator() }
}



class ViewControllerPop: ViewController {
    @IBAction func pop() {
        performSeguePop()
    }
}
extension ViewControllerPop : CYNavigationPop  {
    var popAnimator:UIViewControllerAnimatedTransitioning? { return self.getPopAnimator() }
}

