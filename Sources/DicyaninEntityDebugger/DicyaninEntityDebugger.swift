// Author: Hunter Harris. Copyright © 2025 Dicyanin Labs.

import SwiftUI
import RealityKit
import Combine

public struct EntityDebugInfo {
    public let entity: Entity
    public let name: String
    public let position: SIMD3<Float>
    public let scale: SIMD3<Float>
    public let components: [String]
    
    public init(entity: Entity, name: String? = nil) {
        self.entity = entity
        self.name = name ?? entity.name
        self.position = entity.transform.translation
        self.scale = entity.transform.scale
        self.components = entity.components.map { String(describing: type(of: $0)) }
    }
}

@MainActor
public final class DicyaninEntityDebugger: ObservableObject {
    public static let shared = DicyaninEntityDebugger()
    
    @Published public private(set) var registeredEntities: [EntityDebugInfo] = []
    
    private init() {
        VisualArrowIndicatorSystem.registerSystem()
        VisualArrowIndicatorComponent.registerComponent()
    }
    
    public func register(_ entity: Entity, name: String? = nil) {
        let debugInfo = EntityDebugInfo(entity: entity, name: name)
        if !registeredEntities.contains(where: { $0.entity === entity }) {
            registeredEntities.append(debugInfo)
        }
    }
    
    public func unregister(_ entity: Entity) {
        registeredEntities.removeAll { $0.entity === entity }
    }
    
    public func clear() {
        registeredEntities.removeAll()
    }
} 
