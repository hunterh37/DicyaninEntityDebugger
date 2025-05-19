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

### 1. Make Your Entity Debuggable

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

### 2. Register Your Entity

```swift
let entity = MyEntity()
DicyaninEntityDebugger.shared.register(entity)
```

### 3. Add the Debug View

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

## License

Copyright © 2025 Dicyanin Labs. All rights reserved.

## Author

Hunter Harris

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 