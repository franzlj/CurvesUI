import SwiftUI

/// Composed view that draws the bezier curve, the control point handles, and the control point
/// connection lines. It exposes a binding of normalized control point coordinates, as well as an editing
/// binding to control whether the bezier can be manipulated or not.
public struct BezierView: View {
    
    /// View size for normalization calculations
    @State private var size = CGSize.zero
    
    /// Normalized control points for outside usage
    @Binding var normalizedControlPoints: BezierControlPoints
    
    /// Control point locations in absolute coordinates
    @State private var controlPoints: BezierControlPoints = [:]
    
    /// Whether the control points are shown or not, and if they can be manipulated
    let isEditing: Bool
    
    public var body: some View {
        ZStack {
            if isEditing {
                ControlPointsView(controlPoints: $controlPoints)
            }
            
            BezierShape(controlPoints: controlPoints)
                .stroke(Color.blue, lineWidth: 3)
                .overlay {
                    if isEditing {
                        ControlHandleConnectionsShape(controlPoints: controlPoints)
                            .stroke(Color.gray, lineWidth: 2)
                    }
                }
                .drawingGroup()
                .allowsHitTesting(!isEditing)
                .overlay(GeometryReader { proxy in
                    Color.clear.preference(
                        key: ReadSizePreferenceKey.self,
                        value: proxy.size
                    )
                })
                .onPreferenceChange(ReadSizePreferenceKey.self) { size in
                    self.size = size
                }
        }
        .onChange(of: normalizedControlPoints) { normalized in
            controlPoints = normalized.mapValues { $0.denormalized(into: size) }
        }
        .onChange(of: controlPoints) { denormalized in
            normalizedControlPoints = denormalized.mapValues { $0.normalized(in: size) }
        }
        .onAppear {
            guard controlPoints.isEmpty else { return }
            
            // Denormalize normalized curve coordinates for initial internal values
            DispatchQueue.main.async { 
                controlPoints = normalizedControlPoints
                    .mapValues { $0.denormalized(into: size) }
            }
        }
    }
}

#if DEBUG
struct BezierView_Previews: PreviewProvider {
    static var previews: some View {
        BezierView(
            normalizedControlPoints: .constant(.defaultSetup),
            isEditing: true
        )
    }
}
#endif
