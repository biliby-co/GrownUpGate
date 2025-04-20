# GrownUpGate

A SwiftUI package that provides a parent gate challenge interface for iOS applications. This package helps protect sensitive content or actions by requiring parent verification through simple challenges.

## Features

- Beautiful animated modal interface
- Multiple challenge types (math, word problems, etc.)
- Customizable challenges and answers
- Success callback handling
- iOS 15+ support

## Installation

### Swift Package Manager

Add GrownUpGate to your project using Swift Package Manager:

1. In Xcode, select your project in the navigator
2. Select your target
3. Select the "Package Dependencies" tab
4. Click the "+" button
5. Enter the repository URL: `https://github.com/yourusername/GrownUpGate.git`
6. Click "Add Package"

## Usage

Here's a simple example of how to use GrownUpGate in your SwiftUI view:

```swift
import SwiftUI
import GrownUpGate

struct ContentView: View {
    @State private var showParentGate = false
    
    var body: some View {
        Button("Show Sensitive Content") {
            showParentGate = true
        }
        .sheet(isPresented: $showParentGate) {
            ParentGate(
                isPresented: $showParentGate,
                challenge: ParentGateChallenge.randomChallenge().question,
                correctAnswer: ParentGateChallenge.randomChallenge().answer,
                onSuccess: {
                    // Handle successful parent verification
                    print("Parent verified successfully!")
                }
            )
        }
    }
}
```

### Available Challenges

The package comes with several pre-defined challenges:

- Math challenges (e.g., "What is 7 + 3?")
- Word challenges (e.g., "What is the opposite of 'hot'?")
- Simple math challenges (e.g., "What is 5 × 4?")

You can also create custom challenges:

```swift
let customChallenge = ParentGateChallenge(
    question: "What is your favorite color?",
    answer: "blue"
)
```

## Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 14.0+

## License

GrownUpGate is available under the MIT license. See the LICENSE file for more info. 