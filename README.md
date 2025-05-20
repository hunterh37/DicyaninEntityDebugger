# DicyaninEntityDebugger

A powerful debugging interface for RealityKit entities in visionOS applications. This package provides real-time visualization and inspection of entity properties, transforms, and components through an intuitive SwiftUI interface.

## Features

- 🎯 Real-time entity monitoring and visualization
- 📊 Detailed entity information display
- 🔄 Dynamic entity registration and unregistration
- 📱 Native SwiftUI interface
- 🎨 Clean and modern UI design
- ⚡️ Convenient Entity extensions for easy debugging setup
- 🔘 Quick access button for opening the debug view
- 🎯 Visual arrow indicators for selected entities

## Requirements

- visionOS 1.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/hunterh37/DicyaninEntityDebugger.git", from: "0.0.1")
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

Add the debug button to your app's toolbar:

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

### Visual Arrow Indicators

The package includes a visual arrow indicator system that highlights selected entities:

```swift
// Add arrow indicator with default height (0.4 units)
entity.addArrowIndicator()

// Add arrow indicator with custom height
entity.addArrowIndicator(yOffset: 0.6)

// Remove arrow indicator
entity.removeArrowIndicator()
```

### Advanced Usage

#### Entity Registration

You can register your entity in multiple ways:

```swift
// Using the extension (recommended)
let entity = Entity()
    .registerForDebugging(name: "CustomName")

// Or using the debugger directly
DicyaninEntityDebugger.shared.register(entity, name: "CustomName")

// Unregister when done
entity.unregisterFromDebugging()
```

#### Debug View

The debug view provides detailed information about your entities:

```swift
struct ContentView: View {
    var body: some View {
        EntityDebugView()
    }
}
```

## Features in Detail

### EntityDebugView

The main debugging interface provides:
- List of all registered entities
- Detailed entity information including:
  - Basic information
  - Transform data (position and scale)
  - Component list
- Real-time updates
- Visual selection highlighting

### DicyaninEntityDebugger

The core debugger class manages:
- Entity registration
- Entity unregistration
- Entity information retrieval
- Debug session management

### Entity Extensions

The package provides convenient extensions to `Entity`:

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

### Visual Arrow Indicator System

The arrow indicator system provides:
- Bouncing arrow visualization
- Customizable height offset
- Automatic cleanup
- Smooth animations

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Hunter Harris

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you encounter any issues or have questions, please open an issue on GitHub.
