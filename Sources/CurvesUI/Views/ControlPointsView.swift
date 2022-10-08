import SwiftUI

/// A view that draws the controls points for a curve editor and allows the movement
/// of these points via drag gestures. Is agnostic to the number and kind of control points
/// and should be easy to adapt to different kinds of curve editors.
struct ControlPointsView<Control: CurveControl>: View {
    
    @Binding var controlPoints: [Control: CGPoint]
    
    @State private var gestureStartControlPoints: [Control: CGPoint]?
    @State private var tempOffsetControlPoints: [Control: CGPoint] = .zeroes()
    
    @State private var activeControlPoint: Control?
    @State private var focussedControlPoint: Control?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear // Occupy all space from parent
            
            ForEach(Array(controlPoints.keys)) { controlPoint in
                ControlPointHandleView(
                    focussed: focussedControlPoint == controlPoint, 
                    active: activeControlPoint == controlPoint
                )
                .onHover { hover in
                    focussedControlPoint = hover ? controlPoint : nil
                }
                .offset(controlPoints[controlPoint]?.cgSize ?? .zero)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if gestureStartControlPoints == nil {
                                gestureStartControlPoints = controlPoints
                            }
                            
                            tempOffsetControlPoints[controlPoint] = value.translation.cgPoint
                            
                            // Move companion point with source point if applicable
                            if let companion = controlPoint.companionPoint {
                                tempOffsetControlPoints[companion] = value.translation.cgPoint
                                
                                controlPoints[companion] = offset(for: companion).cgPoint
                            }
                            
                            controlPoints[controlPoint] = offset(for: controlPoint).cgPoint
                            
                            activeControlPoint = controlPoint
                        }
                        .onEnded { value in
                            controlPoints[controlPoint] = offset(for: controlPoint).cgPoint
                            
                            tempOffsetControlPoints[controlPoint] = .zero
                            
                            gestureStartControlPoints = nil
                            
                            // Reset active and focus of control points
                            activeControlPoint = nil
                            focussedControlPoint = nil
                        }
                )
            }
        }
    }
    
    /// Returns the offset of a given control point either based on the starting point
    /// of the current gesture.
    private func offset(for controlPoint: Control) -> CGSize {
        guard
            let tempOffset = tempOffsetControlPoints[controlPoint],
            let offset = gestureStartControlPoints?[controlPoint]
        else {
            return .zero
        }
        
        return CGSize(
            width: tempOffset.x + offset.x,
            height: tempOffset.y + offset.y
        )
    }
}
