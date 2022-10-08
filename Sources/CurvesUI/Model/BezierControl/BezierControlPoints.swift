import SwiftUI

/**
 Discussion:
 Our main data structure is a dictionary of control points with associated CGPoints for the geometry.
 Since paths and shapes can only be animated by values conforming to VectorArithmetic, we need
 to make this complex structure compatible. Luckily, we can nest `AnimatablePair`s, because it is
 itself conforming to VectorArithmetic. The nesting can be arbitrarily deep, as long as we have and know
 the fixed structure of the leaf values.
 */
public typealias BezierControlPoints = [BezierControl: CGPoint]

/// Typealias to easily refer to transformations of bezier points to animatable data
typealias BezierPointsAnimatablePairs = AnimatablePair<
    AnimatablePair<
        AnimatablePair<Double, Double>, // Start
        AnimatablePair<Double, Double> // End
    >,
    AnimatablePair<
        AnimatablePair<Double, Double>, // C1
        AnimatablePair<Double, Double> // C2
    >
>

// MARK: - Transformation API

extension BezierControlPoints {
    
    /// Transform of working bezier control point data into nested AnimatablePairs
    /// to animate curves in the UI layer.
    var animatableData: BezierPointsAnimatablePairs {
        AnimatablePair(
            AnimatablePair(
                AnimatablePair(
                    self[.start, default: .zero].x,
                    self[.start, default: .zero].y
                ),
                AnimatablePair(
                    self[.end, default: .zero].x,
                    self[.end, default: .zero].y
                )
            ),
            AnimatablePair(
                AnimatablePair(
                    self[.c1, default: .zero].x,
                    self[.c1, default: .zero].y
                ),
                AnimatablePair(
                    self[.c2, default: .zero].x,
                    self[.c2, default: .zero].y
                )
            )
        )
    }
    
    /// Init to get a control points dictionary from fitting AnimatablePair data
    init(animatablePairs: BezierPointsAnimatablePairs) {
        self = [
            .start: animatablePairs.first.first.asPoint,
            .end: animatablePairs.first.second.asPoint,
            .c1: animatablePairs.second.first.asPoint,
            .c2: animatablePairs.second.second.asPoint
        ]
    }
}

// MARK: - Helpers

fileprivate extension AnimatablePair where First == Double, Second == Double {
    
    /// Creates a CGPoint from an AnimtablePair that might contain coordinates.
    var asPoint: CGPoint {
        CGPoint(x: first, y: second)
    }
}
