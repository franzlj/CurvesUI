import SwiftUI

struct BezierShape: Shape {
    typealias AnimatableData = BezierPointsAnimatablePairs
    
    var controlPoints: BezierControlPoints
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            guard
                !self.controlPoints.isEmpty,
                let start = controlPoints[.start],
                let end = controlPoints[.end],
                let c1 = controlPoints[.c1],
                let c2 = controlPoints[.c2]
            else { return }
            
            // Bezier Curve
            path.move(to: start)
            path.addCurve(to: end, control1: c1, control2: c2)
        }
    }
    
    var animatableData: BezierPointsAnimatablePairs {
        get {
            controlPoints.animatableData
        }
        set {
            controlPoints = BezierControlPoints(animatablePairs: newValue)
        }
    }
}
