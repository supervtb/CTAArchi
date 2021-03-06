import ComposableArchitecture

let articleReducer = Reducer<ArticleState, ArticleActions, ArticleEnvironment> { state, action, environment in
    switch action {
    case let .dataLoaded(.success(response)):
        state.lesson = response
        return .none
    case .dataLoaded(.failure):
        return .none
    case .loadData:
        return environment.dbClient
            .fetchLesson(state.lessonId)
            .receive(on: environment.mainQueue)
            .catchToEffect(ArticleActions.dataLoaded)
    case .toggleFavorite:
        state.isFavorite = !state.isFavorite
        return .none
    }
}
