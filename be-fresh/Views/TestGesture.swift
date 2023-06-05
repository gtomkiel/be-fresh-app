import SwiftUI

struct TestGesture: View {
    @State private var isSwiped = false
    @GestureState private var swipeOffset: CGSize = .zero
    
    var body: some View {
        let swipeGesture = MagnificationGesture()
            .updating($swipeOffset) { value, swipeOffset, _ in
                swipeOffset = CGSize(width: value.translation.width, height: 0)
            }
            .onEnded { value in
                if value.translation.width > 100 {
                    // Swipe right action
                    isSwiped = true
                }
            }
        
        return VStack {
            if isSwiped {
                Text("Swiped!")
                    .font(.title)
                    .foregroundColor(.green)
            } else {
                Text("Swipe from left to right")
                    .font(.title)
            }
        }
        .modifier(SwipeModifier(swipeOffset: swipeOffset, swipeGesture: swipeGesture))
    }
}

struct SwipeModifier: AnimatableModifier {
    var swipeOffset: CGSize = .zero
    var swipeGesture: some Gesture = MagnificationGesture()
    
    var animatableData: CGSize {
        get { swipeOffset }
        set { swipeOffset = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: swipeOffset.width)
            .gesture(swipeGesture)
    }
}

struct TestGesture_Previews: PreviewProvider {
    static var previews: some View {
        TestGesture()
    }
}
