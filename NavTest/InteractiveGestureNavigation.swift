//
//  InteractiveGestureNavigation.swift
//  NavTest
//
//  Created by Scott Jones on 1/8/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

public protocol CYNavigationPop {
    func performPop()
    var popAnimator:UIViewControllerAnimatedTransitioning? { get }
}

extension CYNavigationPop where Self : UIViewController {
    public func performPop() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    var popAnimator:UIViewControllerAnimatedTransitioning? { return nil }
}

public typealias SeguePush = ()->()
public protocol CYNavigationPush {
    func performPush()
    func stackPush()->SeguePush?
    var seguePush:String { get }
    var pushAnimator:UIViewControllerAnimatedTransitioning? { get }
}

extension CYNavigationPush where Self : UIViewController {
    public func performPush() {
        if let sp = stackPush()  {
            sp()
        } else {
            self.performSegue(withIdentifier: seguePush, sender: self)
        }
    }
    public func stackPush()->SeguePush? {
        return nil
    }
    public var pushAnimator:UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

public protocol NavigationAnimatable:class, UINavigationControllerDelegate {
    var navigationController:UINavigationController { get set }
    var interactionController:UIPercentDrivenInteractiveTransition? { get set }
    var isPopping :Bool { get set }
    func animator(animationControllerForOperation operation: UINavigationController.Operation,fromViewController fromVC: UIViewController,toViewController toVC: UIViewController)->UIViewControllerAnimatedTransitioning?
}

extension NavigationAnimatable {
    
    public func addToNavigationView() {
        weak var weakSelf                       = self
        self.navigationController.delegate      = weakSelf
    }
    
    public func enable() {
        self.navigationController.view.isUserInteractionEnabled = true
    }
    
    public func disable() {
        self.navigationController.view.isUserInteractionEnabled = false
    }
    
    //MARK: Connect Animators
    public func animator(animationControllerForOperation operation: UINavigationController.Operation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController)->UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return animatorForPop(fromVC)
        } else {
            return animatorForPush(fromVC)
        }
    }
    
    fileprivate func animatorForPop(_ fromVC:UIViewController)->UIViewControllerAnimatedTransitioning? {
        guard let poper = fromVC as? CYNavigationPop else {
            print("View controller does not conform to CYNavigationPop protocol")
            return nil
        }
        let animator                = poper.popAnimator
        if var gAnimator = animator as? NavigationAnimatorIgnorable {
            gAnimator.navAnimatorDelegate  = self
        }
        return animator
    }
    
    fileprivate func animatorForPush(_ fromVC:UIViewController)->UIViewControllerAnimatedTransitioning? {
        guard let pusher = fromVC as? CYNavigationPush else {
            print("View controller does not conform to CYNavigationPush protocol")
            return nil
        }
        let animator                = pusher.pushAnimator
        if var gAnimator = animator as? NavigationAnimatorIgnorable {
            gAnimator.navAnimatorDelegate  = self
        }
        return animator
    }
    
    //MARK: Connect To NavigationStack
    public func popViewController() {
        guard let vc = self.navigationController.viewControllers.last, let currentVC = vc as? CYNavigationPop else {
            print("View controller does not conform to CYNavigationPop protocol")
            return
        }
        isPopping                   = true
        currentVC.performPop()
    }
    
    public func pushViewController() {
        guard let vc = self.navigationController.viewControllers.last, let currentVC = vc as? CYNavigationPush else {
            print("View controller does not conform to CYNavigationPush protocol")
            return
        }
        isPopping                   = false
        currentVC.performPush()
    }
    
}

public protocol NavGestureProtocol:class {
    var direction:SwipeDirectionable { get }
    var navigationAnimatable:NavigationAnimatable { get set }
    var gestureRecognizer:UIGestureRecognizer { get }
    func gestureFired(_ recognizer:UIPanGestureRecognizer)
    func beginInteractiveTransition(_ recognizer:UIPanGestureRecognizer)
    func updateInteractiveTransition(_ recognizer:UIPanGestureRecognizer)
    func endInteractiveTransition(_ recognizer:UIPanGestureRecognizer)
    func denyGestures()
    func acceptGestures()
    func untie()
}
extension NavGestureProtocol {
    
    func handleFiredGesture(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state == .began {
            self.beginInteractiveTransition(recognizer)
        } else if recognizer.state == .changed {
            self.updateInteractiveTransition(recognizer)
        } else if recognizer.state == .ended {
            self.endInteractiveTransition(recognizer)
        }
    }
    
    public func untie() {
        self.gestureRecognizer.delegate = nil
        self.gestureRecognizer.removeTarget(nil, action:nil)
        self.gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
    }
    
    public func beginInteractiveTransition(_ recognizer:UIPanGestureRecognizer) {
        guard let view = recognizer.view else { return }
        if recognizer != self.gestureRecognizer {
            return
        }
        let velocity                            = recognizer.velocity(in: view)
        if direction.wrongDirection(velocity) {
            return
        }
        navigationAnimatable.interactionController = UIPercentDrivenInteractiveTransition()
        if direction.pushPlaneBroken(velocity) {
            navigationAnimatable.pushViewController()
        } else {
            navigationAnimatable.popViewController()
        }
    }
    
    public func updateInteractiveTransition(_ recognizer:UIPanGestureRecognizer) {
        guard let view = recognizer.view else { return }
        guard let ic = navigationAnimatable.interactionController else { return }
        let translation                         = recognizer.translation(in: view)
        let percent                             = direction.percent(translation, view: view)
        if navigationAnimatable.isPopping {
            if !direction.popPercentPlaneBroken(percent) { return }
        } else {
            if !direction.pushPercentPlaneBroken(percent) { return }
        }
        let abspercent                          = fabs(percent)
        ic.update(abspercent)
    }
    
    public func endInteractiveTransition(_ recognizer:UIPanGestureRecognizer) {
        guard let view = recognizer.view else { return }
        let translation                         = recognizer.translation(in: view)
        let percent                             = direction.percent(translation, view: view)
        let abpercent                           = fabs(percent)
        guard let ic = navigationAnimatable.interactionController else { return }
        if navigationAnimatable.isPopping {
            if direction.popPercentPlaneBroken(percent) {
                if abpercent > 0.10 {
                    if direction.popPlaneBroken(recognizer.velocity(in: view)) {
                        ic.finish()
                        navigationAnimatable.interactionController = nil
                        return
                    }
                }
            }
        } else {
            if direction.pushPercentPlaneBroken(percent) {
                if abpercent > 0.10 {
                    if direction.pushPlaneBroken(recognizer.velocity(in: view)) {
                        ic.finish()
                        navigationAnimatable.interactionController = nil
                        return
                    }
                }
            }
        }
        ic.cancel()
        navigationAnimatable.interactionController = nil
    }
    
}
