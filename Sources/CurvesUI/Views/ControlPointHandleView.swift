import SwiftUI

/// View that represents a control point handle to facilitate direct manipulation
/// within a curve editor.
struct ControlPointHandleView: View {
    private var size: CGFloat {
        active || focussed ? 24 : 16
    }
    
    let focussed: Bool
    let active: Bool
    
    var body: some View {
        Circle()
            .stroke(Color.white)
            .background(Color(uiColor: .systemFill))
            .clipShape(Circle())
            .foregroundColor(Color(uiColor: .systemFill))
            .frame(width: size, height: size)
            .offset(x: -size / 2, y: -size / 2)
            .animation(.linear(duration: 0.05), value: active || focussed)
    }
}
