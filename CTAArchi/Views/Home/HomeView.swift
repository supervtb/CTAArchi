import SwiftUI
import ComposableArchitecture

struct HomeView: View {

    @State var firstAppear: Bool = true

    let store: Store<HomeState, HomeActions>

    var body: some View {
        WithViewStore(self.store) { viewStore in

            let lessons = viewStore.lessons // .map({ $0.elements }) ?? [Lesson]()
            
            if lessons == nil {
                ProgressView()
                    .onAppear {
                        if firstAppear {
                            viewStore.send(.loadData)
                            self.firstAppear = false
                        }
                    }
            } else {
                List(lessons!) { lesson in
                    NavigationLink {
                        ArticleView(store: Store(
                            initialState: ArticleState(lessonId: lesson.id),
                            reducer: articleReducer,
                            environment: ArticleEnvironment.live
                        ))
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
}
