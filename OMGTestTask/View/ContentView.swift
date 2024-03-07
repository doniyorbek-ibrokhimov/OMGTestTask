import SwiftUI

internal struct ContentView: View {
    @ObservedObject internal var viewModel: ContentViewModel
    
    internal var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1..<150) { _ in
                    self.horizontalItemViews
                }
            }
        }
        .environmentObject(self.viewModel)
        .onDisappear {
            self.viewModel.stopTimer()
        }
    }
    
    private var horizontalItemViews: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(1..<15) { _ in
                    ItemView()
                        .equatable()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

private struct ItemView: View, Equatable {
    @EnvironmentObject private var viewModel: ContentViewModel
    @State private var number = Int.random(in: 1...100)
    @State private var isPressed = false

    internal var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 5)
            .frame(width: 70, height: 70)
            .overlay { Text(self.number.description) }
            .scaleEffect(self.isPressed ? 0.8 : 1.0)
            .onTapGesture { }
            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: 0, perform: {
                
            }, onPressingChanged: { isPressing in
                withAnimation {
                    self.isPressed = isPressing
                }
            })
            .padding(10)
            .onReceive(viewModel.timer, perform: { _ in
                number = Int.random(in: 1...100)
            })
    }
    
    internal static func == (lhs: ItemView, rhs: ItemView) -> Bool {
        lhs.number == rhs.number
    }
}

#Preview {
    ContentView(viewModel: .init())
}
