import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    let store: Store<RootState, RootAction>

    var body: some View {
        TabView {
            NavigationView {
                HomeView(store: self.store.scope(state: \.home, action: RootAction.home))
            }
            .tabItem {
                Image(systemName: "house")
                Text("Learn Now")
            }
            .tag(1)

            NavigationView {
                EmptyView()
            }
            .tabItem {
                Image(systemName: "square.grid.2x2")
                Text("Courses")
            }
            .tag(2)
        }
    }
}
