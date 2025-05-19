// Author: Hunter Harris. Copyright © 2025 Dicyanin Labs.

import SwiftUI
import RealityKit

public struct EntityDebugView: View {
    @State private var selectedEntity: EntityDebugInfo?
    @State private var entities: [EntityDebugInfo] = []
    
    public init() {}
    
    public var body: some View {
        NavigationSplitView {
            List(entities, id: \.entity.id) { entity in
                EntityRowView(entity: entity)
                    .onTapGesture {
                        selectedEntity = entity
                    }
            }
            .navigationTitle("Entity Debugger")
            .onAppear {
                updateEntities()
            }
        } detail: {
            if let entity = selectedEntity {
                EntityDetailView(entity: entity)
            } else {
                Text("Select an entity to view details")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private func updateEntities() {
        entities = DicyaninEntityDebugger.shared.getRegisteredEntities()
    }
}

private struct EntityRowView: View {
    let entity: EntityDebugInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entity.name)
                .font(.headline)
            HStack {
                Text("Position:")
                Text(String(format: "X: %.2f, Y: %.2f, Z: %.2f",
                           entity.position.x,
                           entity.position.y,
                           entity.position.z))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct EntityDetailView: View {
    let entity: EntityDebugInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    DetailSection(title: "Basic Info") {
                        InfoRow(title: "Name", value: entity.name)
                    }
                    
                    DetailSection(title: "Transform") {
                        InfoRow(title: "Position",
                               value: String(format: "X: %.2f, Y: %.2f, Z: %.2f",
                                           entity.position.x,
                                           entity.position.y,
                                           entity.position.z))
                        InfoRow(title: "Scale",
                               value: String(format: "X: %.2f, Y: %.2f, Z: %.2f",
                                           entity.scale.x,
                                           entity.scale.y,
                                           entity.scale.z))
                    }
                    
                    DetailSection(title: "Components") {
                        ForEach(entity.components, id: \.self) { component in
                            Text(component)
                                .font(.system(.body, design: .monospaced))
                                .padding(.vertical, 2)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(entity.name)
    }
}

private struct DetailSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .bold()
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

private struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.system(.body, design: .monospaced))
        }
    }
} 