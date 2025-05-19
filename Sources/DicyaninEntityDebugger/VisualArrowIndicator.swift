// Author: Hunter Harris. Copyright © 2025 Dicyanin Labs.

import Foundation
import RealityKit

/// Part of arrow indicator system, add this to target entity you want to have an arrow, and call entity.addArrowIndicator
struct VisualArrowIndicatorComponent: Component {
    var animationProgress: Float = 0.0 // Track bounce progress
    var direction: Float = 1.0 // 1.0 for moving up, -1.0 for moving down
    var arrowHeight: Float = 0.02 // Max height offset for the bounce
    var yOffset: Float = 0.4 // Base height above the entity
    
    public init(animationProgress: Float = 0.0, direction: Float = 1.0, arrowHeight: Float = 0.02, yOffset: Float = 0.4) {
        self.animationProgress = animationProgress
        self.direction = direction
        self.arrowHeight = arrowHeight
        self.yOffset = yOffset
    }
}

final class VisualArrowIndicatorSystem: System {
    private let bounceSpeed: Float = 0.8 // Control how fast the arrow bounces

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        // Query entities with the ArrowIndicatorComponent and process them with map
        let _ = context.scene.performQuery(
            EntityQuery(where: .has(VisualArrowIndicatorComponent.self))
        ).map { entity -> Void in
            guard var arrowComponent = entity.components[VisualArrowIndicatorComponent.self] else {
                return
            }
            
            // Calculate new animation progress
            arrowComponent.animationProgress += bounceSpeed * arrowComponent.direction * Float(context.deltaTime)
            
            // Reverse direction at limits
            if arrowComponent.animationProgress > 1.0 {
                arrowComponent.direction = -1.0
                arrowComponent.animationProgress = 1.0
            } else if arrowComponent.animationProgress < 0.0 {
                arrowComponent.direction = 1.0
                arrowComponent.animationProgress = 0.0
            }

            // Compute new position for the arrow entity (bouncing effect)
            let bounceOffset = sin(arrowComponent.animationProgress * .pi) * arrowComponent.arrowHeight
            if let arrowEntity = entity.children.first(where: { $0 is ArrowEntity }) {
                arrowEntity.position.y = arrowComponent.yOffset + bounceOffset
            }

            // Update the component back to the entity
            entity.components[VisualArrowIndicatorComponent.self] = arrowComponent
        }
    }
}

public class ArrowEntity: Entity, HasModel {
    required init() {
        super.init()
        createArrowModel()
    }

    private func createArrowModel() {
        // Create arrow shaft (cylinder)
        let shaftMesh = MeshResource.generateCylinder(
            height: 0.1,
            radius: 0.005
        )
        
        // Create arrow tip (cone)
        let tipMesh = MeshResource.generateCone(
            height: 0.03,
            radius: 0.01
        )
        
        // Create materials
        var shaftMaterial = SimpleMaterial()
        shaftMaterial.color = .init(tint: .systemBlue)
        
        var tipMaterial = SimpleMaterial()
        tipMaterial.color = .init(tint: .systemBlue)
        
        // Create shaft entity
        let shaftEntity = Entity()
        shaftEntity.components[ModelComponent.self] = ModelComponent(mesh: shaftMesh, materials: [shaftMaterial])
        shaftEntity.position = SIMD3<Float>(0, 0.05, 0) // Position at half height
        
        // Create tip entity
        let tipEntity = Entity()
        tipEntity.components[ModelComponent.self] = ModelComponent(mesh: tipMesh, materials: [tipMaterial])
        tipEntity.position = SIMD3<Float>(0, 0.115, 0) // Position at top of shaft
        
        // Add both parts to the arrow entity
        self.addChild(shaftEntity)
        self.addChild(tipEntity)
        
        // Position the entire arrow above the entity
        self.position = SIMD3<Float>(0, 0, 0) // Base position, yOffset will be handled by the system
        
        // Rotate to point downward
        self.orientation = simd_quatf(angle: .pi, axis: SIMD3<Float>(1, 0, 0))
    }
}

// Extension to add arrow indicator functionality to Entity
public extension Entity {
    func addArrowIndicator(yOffset: Float = 0.4) {
        // Add the arrow indicator component
        self.components[VisualArrowIndicatorComponent.self] = VisualArrowIndicatorComponent(yOffset: yOffset)
        
        // Create and add the arrow entity
        let arrowEntity = ArrowEntity()
        self.addChild(arrowEntity)
    }
    
    func removeArrowIndicator() {
        // Remove the arrow indicator component
        self.components.remove(VisualArrowIndicatorComponent.self)
        
        // Remove the arrow entity if it exists
        if let arrowEntity = self.children.first(where: { $0 is ArrowEntity }) {
            arrowEntity.removeFromParent()
        }
    }
} 
