//
//  CMNavigationViewController.swift
//  NavTest
//
//  Created by Scott Jones on 1/5/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

enum AnimationType {
    case vertical
    case horizontal
    case shrink
    case fade
}

class NavigationViewController : UINavigationController {
   
    var animationType:AnimationType     = .vertical
    var navAnimationManager:NavigationAnimatable!
    var gestureRecognizer:GestureNavigatorRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navAnimationManager             = NavigationStackAnimator(nav:self)
        let direction                   = SwipeDirection(vertex:.y, magnitude:.positive)
        gestureRecognizer               = GestureNavigatorRecognizer(navigationAnimatable: navAnimationManager, direction:direction)
        
        changeGestureForType(.shrink)
    }

    func changeGestureForType(_ type:AnimationType) {
        animationType = type
        switch animationType {
        case .vertical:
            gestureRecognizer.direction = SwipeDirection(vertex:.y, magnitude:.positive)
        default:
            gestureRecognizer.direction = SwipeDirection(vertex:.x, magnitude:.negative)
        }
    }
    
}
