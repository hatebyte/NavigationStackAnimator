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
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                                                              from fromVC: UIViewController,
                                                                                 to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.animator(animationControllerForOperation:operation, fromViewController:fromVC, toViewController:toVC)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }
}
