import SwiftUI
import ComposableArchitecture

@main
struct CTAArchiApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(initialState: RootState(),
                             reducer: rootReducer,
                             environment: RootEnvironment.live
                            )
            )
        }
    }
}
