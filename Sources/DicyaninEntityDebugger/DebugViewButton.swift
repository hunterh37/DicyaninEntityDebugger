// Author: Hunter Harris. Copyright © 2025 Dicyanin Labs.

import SwiftUI

/// A button that opens the EntityDebugView in a new window.
public struct DebugViewButton: View {
    @Environment(\.openWindow) private var openWindow
    
    public init() {}
    
    public var body: some View {
        Button {
            openWindow(id: "entity-debug-view")
        } label: {
            Label("Debug Entities", systemImage: "ladybug")
        }
        .fontWeight(.semibold)
    }
}

#Preview {
    DebugViewButton()
} 