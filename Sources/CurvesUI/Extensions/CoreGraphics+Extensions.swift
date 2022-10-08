import Foundation

extension CGPoint {
    var cgSize: CGSize { CGSize(width: x, height: y) }
}

extension CGSize {
    var cgPoint: CGPoint { CGPoint(x: width, y: height) }
}

extension CGPoint {
    public static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    public static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

extension CGPoint {
    func normalized(in size: CGSize) -> CGPoint {
        CGPoint(
            x: x / size.width,
            y: y / size.height
        )
    }
    
    func denormalized(into size: CGSize) -> CGPoint {
        CGPoint(
            x: x * size.width,
            y: y * size.height
        )
    }
    
    static func randomNormalizedPoint() -> CGPoint {
        CGPoint(
            x: Double.random(in: 0..<1),
            y: Double.random(in: 0..<1)
        )
    }
}

extension CGPoint: CustomStringConvertible {
    
    public var description: String {
        "(X: \(x.readableNumber), Y: \(y.readableNumber))"
    }
}

extension CGFloat {
    
    var readableNumber: String {
        "\((Double(self) * 100).rounded() / 100)"
    }
}
