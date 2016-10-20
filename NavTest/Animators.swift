//
//  Animators.swift
//  NavTest
//
//  Created by Scott Jones on 1/6/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

protocol NavigationAnimatorIgnorable {
    var navAnimatorDelegate : NavigationAnimatable? { get set }
}

class PopRightAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
   
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let b = context.containerView.bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        firstVCView?.frame                   = b
        secondVCView?.frame                  = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        context.containerView.addSubview(secondVCView!)
        context.containerView.insertSubview(firstVCView!, aboveSubview:secondVCView!)
        
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            secondVCView?.frame              = b
            firstVCView?.frame               = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
            
        }, completion: { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
                context.completeTransition(!context.transitionWasCancelled)
        }) 
    }
    
}

class PushLeftAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let b = UIScreen.main.bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        secondVCView?.frame                  = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        firstVCView?.frame                   = b
        
        context.containerView.addSubview(firstVCView!)
        context.containerView.insertSubview(secondVCView!, aboveSubview:firstVCView!)
        
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            secondVCView?.frame              = b
            firstVCView?.frame               = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
            
        }, completion: { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            context.completeTransition(!context.transitionWasCancelled)
                
        }) 
    }
    
}


class PopTopAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let b = context.containerView.bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        firstVCView?.frame                   = b
        secondVCView?.frame                  = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        context.containerView.addSubview(secondVCView!)
        context.containerView.insertSubview(firstVCView!, aboveSubview:secondVCView!)
        
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            secondVCView?.frame              = b
            firstVCView?.frame               = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
            
        }, completion: { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
                context.completeTransition(!context.transitionWasCancelled)
        }) 
    }
    
}

class PushBottomAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let b = UIScreen.main.bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        secondVCView?.frame                  = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
        firstVCView?.frame                   = b
        
        context.containerView.addSubview(firstVCView!)
        context.containerView.insertSubview(secondVCView!, aboveSubview:firstVCView!)
        
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            secondVCView?.frame              = b
            firstVCView?.frame               = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
            
        }, completion: { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
                context.completeTransition(!context.transitionWasCancelled)
        }) 
    }
    
}

class PopFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        let b                               = context.containerView.bounds
        
        firstVCView?.frame                   = b
        secondVCView?.frame                  = b
        firstVCView?.alpha                   = 1
        context.containerView.addSubview(secondVCView!)
        context.containerView.insertSubview(firstVCView!, aboveSubview:secondVCView!)
        
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            firstVCView?.alpha               = 0
            
        }, completion: { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            context.completeTransition(!context.transitionWasCancelled)
        }) 
    }
    
}

class PushFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        let b                               = context.containerView.bounds
 
        firstVCView?.frame                   = b
        secondVCView?.frame                  = b
        secondVCView?.alpha                  = 0
        context.containerView.addSubview(firstVCView!)
        context.containerView.insertSubview(secondVCView!, aboveSubview:firstVCView!)
        
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            secondVCView?.alpha              = 1
            
        }, completion: { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            
            context.completeTransition(!context.transitionWasCancelled)
        }) 
    }
    
}

class PopShrinkAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let b                               = UIScreen.main.bounds
        
        firstVCView?.frame                   = b
        secondVCView?.frame                  = b
        secondVCView?.transform              = CGAffineTransform(scaleX: 0.01, y: 0.01)
        firstVCView?.transform               = CGAffineTransform(scaleX: 1, y: 1)
        firstVCView?.alpha                   = 1
        secondVCView?.alpha                  = 0
 
        context.containerView.addSubview(firstVCView!)
        context.containerView.insertSubview(secondVCView!, aboveSubview:firstVCView!)
        
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            secondVCView?.transform          = CGAffineTransform(scaleX: 1, y: 1)
            secondVCView?.alpha              = 1
 
        }, completion: { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            firstVCView?.transform           = CGAffineTransform(scaleX: 1, y: 1)
            secondVCView?.transform          = CGAffineTransform(scaleX: 1, y: 1)
            firstVCView?.alpha               = 1
            secondVCView?.alpha              = 1
            context.completeTransition(!context.transitionWasCancelled)
        }) 
    }
    
}

class PushShrinkAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let b                               = UIScreen.main.bounds

        secondVCView?.frame                  = b
        firstVCView?.frame                   = b
        
        context.containerView.addSubview(secondVCView!)
        context.containerView.insertSubview(firstVCView!, aboveSubview:secondVCView!)
 
        navAnimatorDelegate?.disable()
        UIView.animate(withDuration: self.transitionDuration(using: context), animations: { () -> Void in
            firstVCView?.transform           = CGAffineTransform(scaleX: 0.001, y: 0.001)
            firstVCView?.alpha               = 0
            
        }, completion: { [unowned self] (Finished) -> Void in
            firstVCView?.transform           = CGAffineTransform(scaleX: 1, y: 1)
            secondVCView?.transform          = CGAffineTransform(scaleX: 1, y: 1)
            firstVCView?.alpha               = 1
            secondVCView?.alpha              = 1
            self.navAnimatorDelegate?.enable()
            context.completeTransition(!context.transitionWasCancelled)
        }) 
    }
    
}

