//
//  CMNavigationViewController.swift
//  NavTest
//
//  Created by Scott Jones on 1/5/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

enum AnimationType {
    case Vertical
    case Horizontal
    case Shrink
    case Fade
}

class NavigationViewController : UINavigationController {
   
    var animationType:AnimationType     = .Vertical
    var navAnimationManager:NavigationAnimatable!
    var gestureRecognizer:GestureNavigatorRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navAnimationManager             = NavigationStackAnimator(nav:self)
        let direction                   = SwipeDirection(vertex:.Y, magnitude:.Positive)
        gestureRecognizer               = GestureNavigatorRecognizer(navigationAnimatable: navAnimationManager, direction:direction)
        
        changeGestureForType(.Shrink)
    }

    func changeGestureForType(type:AnimationType) {
        animationType = type
        switch animationType {
        case .Vertical:
            gestureRecognizer.direction = SwipeDirection(vertex:.Y, magnitude:.Positive)
        default:
            gestureRecognizer.direction = SwipeDirection(vertex:.X, magnitude:.Negative)
        }
    }
    
}