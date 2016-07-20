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
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        
        let b = context.containerView()!.bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        firstVCView.frame                   = b
        secondVCView.frame                  = CGRectMake(-screenWidth, 0, screenWidth, screenHeight)
        
        context.containerView()!.addSubview(secondVCView)
        context.containerView()!.insertSubview(firstVCView, aboveSubview:secondVCView)
        
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            secondVCView.frame              = b
            firstVCView.frame               = CGRectMake(screenWidth, 0, screenWidth, screenHeight)
            
        }) { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
                context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}

class PushLeftAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        
        let b = UIScreen.mainScreen().bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        secondVCView.frame                  = CGRectMake(screenWidth, 0, screenWidth, screenHeight)
        firstVCView.frame                   = b
        
        context.containerView()!.addSubview(firstVCView)
        context.containerView()!.insertSubview(secondVCView, aboveSubview:firstVCView)
        
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            secondVCView.frame              = b
            firstVCView.frame               = CGRectMake(-screenWidth, 0, screenWidth, screenHeight)
            
        }) { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            context.completeTransition(!context.transitionWasCancelled())
                
        }
    }
    
}


class PopTopAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        
        let b = context.containerView()!.bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        firstVCView.frame                   = b
        secondVCView.frame                  = CGRectMake(0, screenHeight, screenWidth, screenHeight)
        
        context.containerView()!.addSubview(secondVCView)
        context.containerView()!.insertSubview(firstVCView, aboveSubview:secondVCView)
        
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            secondVCView.frame              = b
            firstVCView.frame               = CGRectMake(0, -screenHeight, screenWidth, screenHeight)
            
        }) { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
                context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}

class PushBottomAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        
        let b = UIScreen.mainScreen().bounds
        let screenWidth                     = b.size.width
        let screenHeight                    = b.size.height
        
        secondVCView.frame                  = CGRectMake(0, -screenHeight, screenWidth, screenHeight)
        firstVCView.frame                   = b
        
        context.containerView()!.addSubview(firstVCView)
        context.containerView()!.insertSubview(secondVCView, aboveSubview:firstVCView)
        
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            secondVCView.frame              = b
            firstVCView.frame               = CGRectMake(0, screenHeight, screenWidth, screenHeight)
            
        }) { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
                context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}

class PopFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        let b                               = context.containerView()!.bounds
        
        firstVCView.frame                   = b
        secondVCView.frame                  = b
        firstVCView.alpha                   = 1
        context.containerView()!.addSubview(secondVCView)
        context.containerView()!.insertSubview(firstVCView, aboveSubview:secondVCView)
        
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            firstVCView.alpha               = 0
            
        }) { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}

class PushFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        let b                               = context.containerView()!.bounds
 
        firstVCView.frame                   = b
        secondVCView.frame                  = b
        secondVCView.alpha                  = 0
        context.containerView()!.addSubview(firstVCView)
        context.containerView()!.insertSubview(secondVCView, aboveSubview:firstVCView)
        
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            secondVCView.alpha              = 1
            
        }) { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            
            context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}

class PopShrinkAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        
        let b                               = UIScreen.mainScreen().bounds
        
        firstVCView.frame                   = b
        secondVCView.frame                  = b
        secondVCView.transform              = CGAffineTransformMakeScale(0.01, 0.01)
        firstVCView.transform               = CGAffineTransformMakeScale(1, 1)
        firstVCView.alpha                   = 1
        secondVCView.alpha                  = 0
 
        context.containerView()!.addSubview(firstVCView)
        context.containerView()!.insertSubview(secondVCView, aboveSubview:firstVCView)
        
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            secondVCView.transform          = CGAffineTransformMakeScale(1, 1)
            secondVCView.alpha              = 1
 
        }) { [unowned self] (Finished) -> Void in
            self.navAnimatorDelegate?.enable()
            firstVCView.transform           = CGAffineTransformMakeScale(1, 1)
            secondVCView.transform          = CGAffineTransformMakeScale(1, 1)
            firstVCView.alpha               = 1
            secondVCView.alpha              = 1
            context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}

class PushShrinkAnimator: NSObject, UIViewControllerAnimatedTransitioning, NavigationAnimatorIgnorable {
    
    var navAnimatorDelegate:NavigationAnimatable?
    
    func transitionDuration(context: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(context: UIViewControllerContextTransitioning) {
        let fVC                             = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let firstVCView                     = fVC.view
        let secondVCView                    = context.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        
        let b                               = UIScreen.mainScreen().bounds

        secondVCView.frame                  = b
        firstVCView.frame                   = b
        
        context.containerView()!.addSubview(secondVCView)
        context.containerView()!.insertSubview(firstVCView, aboveSubview:secondVCView)
 
        navAnimatorDelegate?.disable()
        UIView.animateWithDuration(self.transitionDuration(context), animations: { () -> Void in
            firstVCView.transform           = CGAffineTransformMakeScale(0.001, 0.001)
            firstVCView.alpha               = 0
            
        }) { [unowned self] (Finished) -> Void in
            firstVCView.transform           = CGAffineTransformMakeScale(1, 1)
            secondVCView.transform          = CGAffineTransformMakeScale(1, 1)
            firstVCView.alpha               = 1
            secondVCView.alpha              = 1
            self.navAnimatorDelegate?.enable()
            context.completeTransition(!context.transitionWasCancelled())
        }
    }
    
}

