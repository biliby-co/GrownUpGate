import SwiftUI
import AVFoundation

@available(iOS 15.0, *)
public struct ParentGate: View {
    @Binding private var isPresented: Bool
    private let onSuccess: () -> Void
    private let onFailure: () -> Void
    
    @State private var offset: CGFloat = -1000
    @State private var scale: CGFloat = 0.8
    @State private var showError: Bool = false
    @State private var showSuccess: Bool = false
    @State private var opacity: Double = 0
    @State private var keypadOpacity: Double = 0
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var firstNumber: Int
    @State private var secondNumber: Int
    @State private var answerValue: String = ""
    
    private var question: String {
        "\(firstNumber) + \(secondNumber) = ?"
    }
    
    var expectedAnswer: String {
        String(firstNumber + secondNumber)
    }
    
    public init(
        isPresented: Binding<Bool>,
        onSuccess: @escaping () -> Void,
        onFailure: @escaping () -> Void = {}
    ) {
        self._isPresented = isPresented
        self.firstNumber = Int.random(in: 20...80)
        self.secondNumber = Int.random(in: 2...9)
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.4 * opacity)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismiss()
                }
            
            VStack(spacing: 20) {
                Text("Parent Gate")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(question)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                Text(answerValue.isEmpty ? "0" : answerValue)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .frame(height: 50)
                
                if showError {
                    Text("Incorrect answer. Please try again.")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                if showSuccess {
                    Text("Correct!")
                        .foregroundColor(.green)
                        .font(.title2)
                        .fontWeight(.bold)
                        .transition(.scale.combined(with: .opacity))
                }
                
                // Keypad container with its own opacity
                VStack(spacing: 20) {
                    // Keypad - Row 1
                    HStack(spacing: 30) {
                        keypadButton("1")
                        keypadButton("2")
                        keypadButton("3")
                        keypadButton("4")
                        keypadButton("5")
                    }
                    
                    // Keypad - Row 2
                    HStack(spacing: 30) {
                        keypadButton("6")
                        keypadButton("7")
                        keypadButton("8")
                        keypadButton("9")
                        keypadButton("0")
                    }
                }
                .opacity(keypadOpacity)
                .padding(.top, 20)
                
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .padding(.top, 10)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.8))
            )
            .padding()
            .offset(y: offset)
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            playAudio("AskForHelp")
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.5)) {
                offset = 0
                scale = 1
                opacity = 1
            }
            
            // Then fade in the keypad after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeIn(duration: 0.4)) {
                    keypadOpacity = 1
                }
            }
        }
    }
    
    private func playAudio(_ file: String) {
        guard let url = Bundle.module.url(forResource: file, withExtension: "m4a") else {
            print("Could not find audio file in bundle: \(Bundle.module.bundlePath)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not play audio file: \(error)")
        }
    }
    
    private func keypadButton(_ label: String) -> some View {
        Button(action: {
            handleKeyPress(label)
        }) {
            Text(label)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
        }
        .disabled(showSuccess)
    }
    
    private func handleKeyPress(_ key: String) {
        if answerValue.count < 2 {
            answerValue += key
            if answerValue.count == 2 {
                checkAnswer()
            }
        }
    }
    
    private func checkAnswer() {
        if answerValue == expectedAnswer {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                showSuccess = true
            }
            
            // Call onSuccess immediately
            onSuccess()
            
            // Dismiss after a short delay to show the success message
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                dismiss()
            }
        } else {
            withAnimation {
                showError = true
            }
            
            playAudio("WrongAnswer")
            
            // Call onFailure immediately
            onFailure()
            
            // Dismiss after a short delay to show the error message
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                dismiss()
            }
        }
    }
    
    private func dismiss() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            offset = 1000
            scale = 0.8
            opacity = 0
            keypadOpacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }
}

@available(iOS 15.0, *)
public struct ParentGateModifier: ViewModifier {
    @Binding var isPresented: Bool
    let onSuccess: () -> Void
    let onFailure: () -> Void
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                ParentGate(
                    isPresented: $isPresented,
                    onSuccess: onSuccess,
                    onFailure: onFailure
                )
            }
        }
    }
}

@available(iOS 15.0, *)
public extension View {
    func parentGate(
        isPresented: Binding<Bool>,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping () -> Void = {}
    ) -> some View {
        modifier(ParentGateModifier(
            isPresented: isPresented,
            onSuccess: onSuccess,
            onFailure: onFailure
        ))
    }
}

@available(iOS 15.0, *)
#Preview {
    struct PreviewWrapper: View {
        @State private var showParentGate = false
        
        var body: some View {
            Button("Show Parent Gate") {
                showParentGate = true
            }
            .parentGate(
                isPresented: $showParentGate,
                onSuccess: {
                    print("Success")
                },
                onFailure: {
                    print("Failure")
                }
            )
        }
    }
    
    return PreviewWrapper()
} 
