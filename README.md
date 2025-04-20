# GrownUpGate

A SwiftUI package that provides a beautiful, animated parent gate for iOS apps. Perfect for protecting sensitive content or features from children.

## Features

- 🎨 Beautiful, modern UI with smooth animations
- 🔢 Math-based challenges that are easy for adults but challenging for children
- 🎭 Animated presentation with a bouncy drop-down effect
- ⌨️ Custom animated keypad with staggered fade-in
- 🎯 Success and failure callbacks
- ⚡️ Easy to integrate with a simple ViewModifier
- 🎮 Interactive dismissal with background tap
- 📱 iOS 15.0+ support

## Installation

### Swift Package Manager

Add GrownUpGate to your Xcode project using Swift Package Manager:

1. In Xcode, go to File > Add Packages...
2. Enter the repository URL: `https://github.com/yourusername/GrownUpGate.git`
3. Click "Add Package"

## Usage

### Basic Usage

```swift
import SwiftUI
import GrownUpGate

struct ContentView: View {
    @State private var showParentGate = false
    
    var body: some View {
        Button("Show Parent Gate") {
            showParentGate = true
        }
        .parentGate(
            isPresented: $showParentGate,
            onSuccess: {
                // Handle successful verification
                print("Parent gate passed!")
            },
            onFailure: {
                // Handle failed verification
                print("Parent gate failed!")
            }
        )
    }
}
```

### Features

- The parent gate presents with a smooth drop-down animation
- The keypad fades in after the main dialog appears
- Incorrect answers show an error message and dismiss the gate
- Correct answers show a success message before dismissing
- Tap the background to dismiss
- The gate automatically handles state management

## Requirements

- iOS 15.0+
- Swift 5.5+
- Xcode 13.0+

## License

GrownUpGate is available under the MIT license. See the LICENSE file for more info. 
