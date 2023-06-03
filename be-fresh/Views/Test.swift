import SwiftUI

struct Test: View {
    @State private var chats = [
        "Chat 1",
        "Chat 2",
        "Chat 3",
        "Chat 4",
        "Chat 5"
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(chats, id: \.self) { chat in
                ChatRowView(chat: chat)
                    .gesture(swipeGesture(chat: chat))
                    .padding(.horizontal)
            }
        }
    }
    
    
    private func swipeGesture(chat: String) -> some Gesture {
        return DragGesture()
            .onChanged { value in
                if value.translation.width < -100 {
                    print("hello")
                }
            }
    }
}

struct ChatRowView: View {
    let chat: String
    @State private var isSwiped = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                if isSwiped {
                    Spacer().frame(width: geometry.size.width)
                        .background(Color.red)
                        .onTapGesture {
                            withAnimation {
                                isSwiped = false
                            }
                        }
                }
                
                Text(chat)
                    .font(.headline)
                    .padding()
            }
            .frame(width: geometry.size.width, height: 44)
            .offset(x: isSwiped ? -geometry.size.width : 0)
            .animation(.easeInOut)
            .gesture(swipeGesture())
        }
    }
    
    private func swipeGesture() -> some Gesture {
        return DragGesture()
            .onChanged { value in
                if value.translation.width < -10 {
                    withAnimation {
                        isSwiped = true
                    }
                }
                if value.translation.width > 10 {
                    withAnimation {
                        isSwiped = false
                    }
                }
            }
            .onEnded { value in
                withAnimation {
                    if value.translation.width < -100 {
                        print("hello")
                    }
                    isSwiped = false
                }
            }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
