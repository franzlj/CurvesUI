import Foundation

/// A type (per definition constrained to enums) that represents a set of control points for
/// a curve which is defined by this set of points.
public protocol CurveControl: Hashable, CaseIterable, Identifiable, CustomStringConvertible {
    // Let's use SE-0280 to define requirements of enums that represent a set
    // of curve controls 🤘
    
    /// Starting point of a curve
    static var start: Self { get }
    
    /// Ending point of a curve
    static var end: Self { get }
    
    /// Each control can define an optional companion point.
    /// Primarily this is used for simultaneous movement during direct manipulation of the curve.
    var companionPoint: Self? { get }
}
