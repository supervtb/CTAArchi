import SwiftUI
import ComposableArchitecture

struct HomeView: View {

    @State var firstAppear: Bool = true

    let store: Store<HomeState, HomeActions>

    var body: some View {
        WithViewStore(self.store) { viewStore in

            let lessons = viewStore.lessons

            List(lessons) { lesson in
                NavigationLink(
                    destination: IfLetStore(
                        self.store.scope(
                            state: \.selection?.value,
                            action: HomeActions.article
                        )
                    ) {
                        ArticleView(store: $0)
                    } else: {
                        ProgressView()
                    },
                    tag: lesson.id,
                    selection: viewStore.binding(
                        get: \.selection?.id,
                        send: HomeActions.setNavigation(selection:)
                    )
                ) {
                    TwoLabelsView(
                        title: lesson.title,
                        subtitle: lesson.description,
                        date: lesson.date?.formatted(),
                        imageUrlString: lesson.image
                    )
                }
                .listRowBackground(EmptyView())
                .listRowSeparator(.hidden)
            }.refreshable(action: {
                viewStore.send(.loadData)
            })
            .navigationTitle("Learn Now")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .onAppear {
                if firstAppear {
                    viewStore.send(.loadData)
                    self.firstAppear = false
                }
            }
        }
    }
}
