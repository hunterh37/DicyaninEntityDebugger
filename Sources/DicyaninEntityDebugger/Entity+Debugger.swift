// Author: Hunter Harris. Copyright © 2025 Dicyanin Labs.

import RealityKit

public extension Entity {
    /// Registers the entity with the DicyaninEntityDebugger.
    /// - Parameter name: Optional custom name for the entity. If nil, the entity's name will be used.
    /// - Returns: The entity instance for method chaining.
    @discardableResult
    func registerForDebugging(name: String? = nil) -> Entity {
        DicyaninEntityDebugger.shared.register(self, name: name)
        return self
    }
    
    /// Unregisters the entity from the DicyaninEntityDebugger.
    /// - Returns: The entity instance for method chaining.
    @discardableResult
    func unregisterFromDebugging() -> Entity {
        DicyaninEntityDebugger.shared.unregister(self)
        return self
    }
} 