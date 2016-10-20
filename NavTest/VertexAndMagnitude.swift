//
//  Enum.swift
//  NavTest
//
//  Created by Scott Jones on 5/24/16.
//  Copyright © 2016 Barf. All rights reserved.
//

import UIKit

public enum Magnitude:CGFloat {
    case positive = 1
    case negative = -1
}

public enum Vertice {
    case x
    case y
}
extension Vertice {
    public var opposite:Vertice {
        switch self {
        case .x:
            return .y
        case .y:
            return .x
        }
    }
    public func pointValue(_ point:CGPoint)->CGFloat {
        switch self {
        case .x:
            return point.x
        case .y:
            return point.y
        }
    }
    public func percent(_ point:CGPoint, view:UIView)->CGFloat {
        switch self {
        case .x:
            return point.x / view.bounds.width
        case .y:
            return point.y / view.bounds.height
        }
    }
}

public struct SwipeDirection {
    public var vertex:Vertice
    public var magnitude:Magnitude
}

extension SwipeDirection {
    
    public func wrongDirection(_ point:CGPoint)->Bool {
        return abs(vertex.opposite.pointValue(point)) > abs(vertex.pointValue(point))
    }
    
    public func pushPlaneBroken(_ point:CGPoint)->Bool {
        return vertex.pointValue(point) * magnitude.rawValue > 0
    }
    
    public func popPlaneBroken(_ point:CGPoint)->Bool {
        return !pushPlaneBroken(point)
    }
    
    public func percent(_ translation:CGPoint, view:UIView)->CGFloat {
        return vertex.percent(translation, view: view)
    }
    
    public func pushPercentPlaneBroken(_ percent:CGFloat)->Bool {
        return percent * magnitude.rawValue > 0
    }
    
    public func popPercentPlaneBroken(_ percent:CGFloat)->Bool {
        return !pushPercentPlaneBroken(percent)
    }
    
}







