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
        topButton?.setTitleColor(UIColor.white, for: .disabled)
        bottomButton?.setTitleColor(UIColor.white, for: .disabled)
        leftButton?.setTitleColor(UIColor.white, for: .disabled)
        rightButton?.setTitleColor(UIColor.white, for: .disabled)
       
        topButton?.setTitleColor(UIColor.darkGray, for: UIControlState())
        bottomButton?.setTitleColor(UIColor.darkGray, for: UIControlState())
        leftButton?.setTitleColor(UIColor.darkGray, for: UIControlState())
        rightButton?.setTitleColor(UIColor.darkGray, for: UIControlState())
        
        topButton?.setTitle("Vertical", for: UIControlState())
        bottomButton?.setTitle("Horizontal", for: UIControlState())
        leftButton?.setTitle("Fade", for: UIControlState())
        rightButton?.setTitle("Shrink", for: UIControlState())
        buttonContainer?.backgroundColor = UIColor.gray
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addHandlers()
        updateButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeHandlers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
 
    func addHandlers() {
        topButton?.addTarget(self, action: #selector(topHit), for: .touchUpInside)
        bottomButton?.addTarget(self, action: #selector(bottomHit), for: .touchUpInside)
        rightButton?.addTarget(self, action: #selector(rightHit), for: .touchUpInside)
        leftButton?.addTarget(self, action: #selector(leftHit), for: .touchUpInside)
    }
    func removeHandlers() {
        topButton?.removeTarget(self, action: #selector(topHit), for: .touchUpInside)
        bottomButton?.removeTarget(self, action: #selector(bottomHit), for: .touchUpInside)
        rightButton?.removeTarget(self, action: #selector(rightHit), for: .touchUpInside)
        leftButton?.removeTarget(self, action: #selector(leftHit), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var gestureNavigationController:NavigationViewController? {
        return self.navigationController as? NavigationViewController
    }
  
    func topHit() {
        gestureNavigationController?.changeGestureForType(.vertical)
        updateButtons()
    }
    
    func bottomHit() {
        gestureNavigationController?.changeGestureForType(.horizontal)
        updateButtons()
    }
    
    func rightHit() {
        gestureNavigationController?.changeGestureForType(.shrink)
        updateButtons()
    }
    
    func leftHit() {
        gestureNavigationController?.changeGestureForType(.fade)
        updateButtons()
    }
    
    func getPushAnimator()->UIViewControllerAnimatedTransitioning? {
        if let gn = self.gestureNavigationController {
            switch gn.animationType {
            case .vertical:
                return PushBottomAnimator()
            case .horizontal:
                return PushLeftAnimator()
            case .fade:
                return PushFadeAnimator()
            case .shrink:
                return PushShrinkAnimator()
            }
        }
        return nil
    }
    
    func getPopAnimator()->UIViewControllerAnimatedTransitioning? {
        if let gn = self.gestureNavigationController {
            switch gn.animationType {
            case .vertical:
                return PopTopAnimator()
            case .horizontal:
                return PopRightAnimator()
            case .fade:
                return PopFadeAnimator()
            case .shrink:
                return PopShrinkAnimator()
            }
        }
        return nil
    }
    
    func enableButtons() {
    }
    
    func updateButtons() {
        topButton?.isEnabled = true
        bottomButton?.isEnabled = true
        leftButton?.isEnabled = true
        rightButton?.isEnabled = true
        if let gn = self.gestureNavigationController {
            switch gn.animationType {
            case .vertical:
                topButton?.isEnabled = false
            case .horizontal:
                bottomButton?.isEnabled = false
            case .fade:
                leftButton?.isEnabled = false
            case .shrink:
                rightButton?.isEnabled = false
            }
        }
    }
    
}

class ViewControllerPush: ViewController {
    var seguePushBlock:SeguePush? 
    @IBAction func push() {
        performPush()
    }
}
extension ViewControllerPush : CYNavigationPush {
    var seguePush:String {
        return "firstViewControllerPush"
    }
    func stackPush()->SeguePush? {
        return {
            print("WHOOOT!!!! PUSH MAN")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerPushPop")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    var pushAnimator:UIViewControllerAnimatedTransitioning? { return self.getPushAnimator() }
}



class ViewControllerPushPop: ViewController {
    @IBAction func push() {
        performPush()
    }
    @IBAction func pop() {
        performPop()
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
        performPop()
    }
}
extension ViewControllerPop : CYNavigationPop  {
    var popAnimator:UIViewControllerAnimatedTransitioning? { return self.getPopAnimator() }
}

