import Foundation

extension Dictionary where Key: CurveControl, Value == CGPoint {
    
    /// Randomized normalized bezier control points data
    static func random() -> Self {
        Dictionary(
            Key.allCases.map {
                ($0, .randomNormalizedPoint())
            },
            uniquingKeysWith: { lhs, rhs in lhs}
        )
    }
    
    /// Initialized dictionary with all bezier control points set to (0, 0)
    static func zeroes() -> Self {
        Dictionary(
            uniqueKeysWithValues: Key
                .allCases
                .map { ($0, CGPoint.zero) }
        )
    }
}
