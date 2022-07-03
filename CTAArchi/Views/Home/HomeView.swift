import SwiftUI
import ComposableArchitecture

struct HomeView: View {

    let store: Store<HomeState, HomeActions>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            let lessons = viewStore.lessons ?? [Lesson]()
            List(lessons) { lesson in
                NavigationLink {
                    ArticleView(
                        title: lesson.title,
                        text: lesson.description,
                        author: lesson.author,
                        date: lesson.date?.formatted(),
                        imageUrlString: lesson.image
                    )
                } label: {
                    TwoLabelsView(
                        title: lesson.title,
                        subtitle: lesson.description,
                        date: lesson.date?.formatted(),
                        imageUrlString: lesson.image
                    )
                }
                .listRowBackground(EmptyView())
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Learn Now")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .onAppear {
                viewStore.send(.loadData)
            }
        }
    }
}
