import SwiftUI

/// Represents and describes a control point of a cubic bezier curve.
/// Start and end are also considered control points.
/// Control points can nominate a companion control that is moved
/// simultaneous during direct manipulation.
public enum BezierControl: CurveControl {
    case start
    case end
    case c1
    case c2
    
    public var id: Int { hashValue }
    
    public var companionPoint: BezierControl? {
        switch self {
        case .start:
            return .c1
        case .end:
            return .c2
        case .c1, .c2:
            return nil
        }
    }
    
    public var description: String {
        switch self {
        case .c1: return "C1"
        case .c2: return "C2"
        case .start: return "Start"
        case .end: return "End"
        }
    }
}
