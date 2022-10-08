import SwiftUI

/// Shape that draws lines to the control point handles.
/// We assume that we usually draw the lines from start / end to their respective companion points.
struct ControlHandleConnectionsShape<Control: CurveControl>: Shape {
    var controlPoints: [Control: CGPoint]
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            guard
                !self.controlPoints.isEmpty,
                let start = controlPoints[.start],
                let end = controlPoints[.end]
            else { return }
            
            path.move(to: start)
            
            // FIX-ME: somehow the generic approach here breaks
            // drawing the handles in our default cubic bezier setup.
            Control.start.companionPoint
                .flatMap { controlPoints[$0] }
                .flatMap {
                    path.move(to: $0)
                }
            
            path.move(to: end)
            
            Control.end.companionPoint
                .flatMap { controlPoints[$0] }
                .flatMap {
                    path.move(to: $0)
                }
        }
    }
}

// MARK: Control Specific Animation Data

extension ControlHandleConnectionsShape where Control == BezierControl {
    
    var animatableData: BezierPointsAnimatablePairs {
        get {
            controlPoints.animatableData
        }
        set {
            controlPoints = BezierControlPoints(animatablePairs: newValue)
        }
    }
}
