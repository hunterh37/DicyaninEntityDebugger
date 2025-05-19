# DicyaninEntityDebugger

A Swift package that provides a powerful debugging interface for RealityKit entities in your SwiftUI applications.

## Overview

DicyaninEntityDebugger offers a comprehensive debugging solution for RealityKit entities, allowing developers to inspect and monitor entity properties, transforms, and components in real-time through an intuitive SwiftUI interface.

## Features

- 🎯 Real-time entity monitoring
- 📊 Detailed entity information display
- 🔄 Dynamic entity registration and unregistration
- 📱 Native SwiftUI interface
- 🎨 Clean and modern UI design
- ⚡️ Convenient Entity extensions for easy debugging setup
- 🔘 Quick access button for opening the debug view

## Requirements

- iOS 15.0+ / macOS 12.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/hunterh37/DicyaninEntityDebugger.git", from: "1.0.0")
]
```

Or add it directly in Xcode:
1. Go to File > Add Packages
2. Enter the repository URL: `https://github.com/hunterh37/DicyaninEntityDebugger.git`
3. Click Add Package

## Usage

### Quick Start

The easiest way to debug an entity is using the provided extension:

```swift
let entity = Entity()
    .registerForDebugging(name: "MyEntity")
```

### Adding the Debug Button

Add the debug button to your app's toolbar or menu:

```swift
struct ContentView: View {
    var body: some View {
        NavigationStack {
            // Your app content
            .toolbar {
                DebugViewButton()
            }
        }
    }
}
```

### Advanced Usage

#### 1. Make Your Entity Debuggable

Conform your entity to the `DicyaninDebuggable` protocol:

```swift
class MyEntity: Entity, DicyaninDebuggable {
    func dicyaninDebugger() -> EntityDebugInfo {
        return EntityDebugInfo(
            entity: self,
            name: "MyEntity",
            position: transform.translation,
            scale: transform.scale,
            components: ["Component1", "Component2"]
        )
    }
}
```

#### 2. Register Your Entity

You can register your entity in multiple ways:

```swift
// Using the extension (recommended)
let entity = MyEntity()
    .registerForDebugging()

// Or using the debugger directly
DicyaninEntityDebugger.shared.register(entity)

// Unregister when done
entity.unregisterFromDebugging()
```

#### 3. Add the Debug View

```swift
struct ContentView: View {
    var body: some View {
        EntityDebugView()
    }
}
```

## Features in Detail

### EntityDebugView

The main debugging interface that provides:
- List of all registered entities
- Detailed entity information including:
  - Basic information
  - Transform data (position and scale)
  - Component list
- Real-time updates

### DicyaninEntityDebugger

The core debugger class that manages:
- Entity registration
- Entity unregistration
- Entity information retrieval
- Debug session management

### Entity Extensions

The package provides convenient extensions to `Entity` for easy debugging setup:

```swift
// Register an entity for debugging
entity.registerForDebugging(name: "CustomName")

// Unregister an entity
entity.unregisterFromDebugging()

// Method chaining
Entity()
    .registerForDebugging()
    .addChild(childEntity)
```

### DebugViewButton

A convenient button component that opens the debug view in a new window:

```swift
// Add to toolbar
.toolbar {
    DebugViewButton()
}

// Or use standalone
DebugViewButton()
```

## License

Copyright © 2025 Dicyanin Labs. All rights reserved.

## Author

Hunter Harris

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 