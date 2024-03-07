import Foundation

internal class ContentViewModel: ObservableObject {
    /// A timer publishing events every second on the main thread.
    internal let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    /// Stops the timer by canceling its upstream connection.
    internal func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
}
