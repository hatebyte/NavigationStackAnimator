//
//  Enum.swift
//  NavTest
//
//  Created by Scott Jones on 5/24/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

public enum Magnitude:CGFloat {
    case Positive = 1
    case Negative = -1
}

public enum Vertice {
    case X
    case Y
}
extension Vertice {
    public var opposite:Vertice {
        switch self {
        case .X:
            return .Y
        case .Y:
            return .X
        }
    }
    public func pointValue(point:CGPoint)->CGFloat {
        switch self {
        case .X:
            return point.x
        case .Y:
            return point.y
        }
    }
    public func percent(point:CGPoint, view:UIView)->CGFloat {
        switch self {
        case .X:
            return point.x / CGRectGetWidth(view.bounds)
        case .Y:
            return point.y / CGRectGetHeight(view.bounds)
        }
    }
}

public struct SwipeDirection {
    public var vertex:Vertice
    public var magnitude:Magnitude
}

extension SwipeDirection {
    
    public func wrongDirection(point:CGPoint)->Bool {
        return abs(vertex.opposite.pointValue(point)) > abs(vertex.pointValue(point))
    }
    
    public func pushPlaneBroken(point:CGPoint)->Bool {
        return vertex.pointValue(point) * magnitude.rawValue > 0
    }
    
    public func popPlaneBroken(point:CGPoint)->Bool {
        return !pushPlaneBroken(point)
    }
    
    public func percent(translation:CGPoint, view:UIView)->CGFloat {
        return vertex.percent(translation, view: view)
    }
    
    public func pushPercentPlaneBroken(percent:CGFloat)->Bool {
        return percent * magnitude.rawValue > 0
    }
    
    public func popPercentPlaneBroken(percent:CGFloat)->Bool {
        return !pushPercentPlaneBroken(percent)
    }
    
}







