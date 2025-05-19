// Author: Hunter Harris. Copyright © 2025 Dicyanin Labs.

import SwiftUI
import RealityKit

public protocol DicyaninDebuggable {
    func dicyaninDebugger() -> EntityDebugInfo
}

public struct EntityDebugInfo {
    public let entity: Entity
    public let name: String
    public let position: SIMD3<Float>
    public let scale: SIMD3<Float>
    public let components: [String]
    
    public init(entity: Entity, name: String, position: SIMD3<Float>, scale: SIMD3<Float>, components: [String]) {
        self.entity = entity
        self.name = name
        self.position = position
        self.scale = scale
        self.components = components
    }
}

public final class DicyaninEntityDebugger {
    public static let shared = DicyaninEntityDebugger()
    
    private var registeredEntities: [EntityDebugInfo] = []
    
    private init() {}
    
    public func register(_ entity: Entity) {
        guard let debuggable = entity as? DicyaninDebuggable else { return }
        let debugInfo = debuggable.dicyaninDebugger()
        if !registeredEntities.contains(where: { $0.entity === entity }) {
            registeredEntities.append(debugInfo)
        }
    }
    
    public func unregister(_ entity: Entity) {
        registeredEntities.removeAll { $0.entity === entity }
    }
    
    public func getRegisteredEntities() -> [EntityDebugInfo] {
        return registeredEntities
    }
    
    public func clear() {
        registeredEntities.removeAll()
    }
} 