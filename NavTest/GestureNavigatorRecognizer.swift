//
//  EnumGestureRecognizer.swift
//  NavTest
//
//  Created by Scott Jones on 5/24/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

public final class GestureNavigatorRecognizer:UIPanGestureRecognizer {
    
    public static func SwipeRightNavigatorRecognizer(navigationAnimatable:NavigationAnimatable)->GestureNavigatorRecognizer {
        return GestureNavigatorRecognizer(navigationAnimatable: navigationAnimatable, direction: SwipeDirection(vertex:.X, magnitude:.Positive))
    }
    public static func SwipeLeftNavigatorRecognizer(navigationAnimatable:NavigationAnimatable)->GestureNavigatorRecognizer {
        return GestureNavigatorRecognizer(navigationAnimatable: navigationAnimatable, direction: SwipeDirection(vertex:.X, magnitude:.Negative))
    }
    public static func SwipeUpNavigatorRecognizer(navigationAnimatable:NavigationAnimatable)->GestureNavigatorRecognizer {
        return GestureNavigatorRecognizer(navigationAnimatable: navigationAnimatable, direction: SwipeDirection(vertex:.Y, magnitude:.Negative))
    }
    public static func SwipeDownNavigatorRecognizer(navigationAnimatable:NavigationAnimatable)->GestureNavigatorRecognizer {
        return GestureNavigatorRecognizer(navigationAnimatable: navigationAnimatable, direction: SwipeDirection(vertex:.Y, magnitude:.Positive))
    }
    
    public var navigationAnimatable:NavigationAnimatable
    public var gestureRecognizer:UIGestureRecognizer { return self }
    public var direction:SwipeDirection
    
    public init(navigationAnimatable:NavigationAnimatable, direction:SwipeDirection) {
        self.navigationAnimatable           = navigationAnimatable
        self.direction                      = direction
        super.init(target:nil, action:nil)
        self.addTarget(self, action:#selector(gestureFired(_:)))
        self.delegate                       = self
        self.navigationAnimatable.navigationController.view.addGestureRecognizer(self)
    }
    
    deinit {
        untie()
    }
    
    public func denyGestures() {
        self.removeTarget(self, action:#selector(gestureFired(_:)))
    }
    
    public func acceptGestures() {
        self.addTarget(self, action:#selector(gestureFired(_:)))
    }
    
}

extension GestureNavigatorRecognizer : NavGestureProtocol {
    
    public func gestureFired(recognizer:UIPanGestureRecognizer) {
        self.handleFiredGesture(recognizer)
    }
    
}

extension GestureNavigatorRecognizer : UIGestureRecognizerDelegate  {
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
