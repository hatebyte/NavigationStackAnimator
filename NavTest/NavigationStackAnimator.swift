//
//  NavStackAnimator.swift
//  NavTest
//
//  Created by Scott Jones on 5/23/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

final class NavigationStackAnimator:NSObject {
    
    var navigationController:UINavigationController
    var interactionController:UIPercentDrivenInteractiveTransition?
    var isPopping                               = false
    
    init(nav:UINavigationController) {
        self.navigationController               = nav
        super.init()
        self.addToNavigationView()
    }
    
}

extension NavigationStackAnimator : NavigationAnimatable {
    func navigationController(navigationController: UINavigationController,
                              animationControllerForOperation operation: UINavigationControllerOperation,
                                                              fromViewController fromVC: UIViewController,
                                                                                 toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.animator(animationControllerForOperation:operation, fromViewController:fromVC, toViewController:toVC)
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }
}