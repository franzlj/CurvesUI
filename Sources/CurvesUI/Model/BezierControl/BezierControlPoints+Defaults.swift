import SwiftUI

extension BezierControlPoints {
    
    /// A default setup of control points suited as a good editor starting point
    static var defaultSetup: Self {
        [
            .start: CGPoint(x: 0.1, y: 0.5),
            .end: CGPoint(x: 0.9, y: 0.5),
            .c1: CGPoint(x: 0.5, y: 0.3),
            .c2: CGPoint(x: 0.5, y: 0.7)
        ]
    }
}
