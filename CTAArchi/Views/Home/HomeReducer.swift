import ComposableArchitecture

let homeReducer = Reducer<HomeState, HomeActions, HomeEnvironment> { state, action, environment in
    switch action {
    case let .dataLoaded(.success(response)):
        state.lessons = response
        return .none
    case .dataLoaded(.failure):
        return .none
    case .loadData:
        return environment.apiClient
            .fetchLessons()
            .receive(on: environment.mainQueue)
            .catchToEffect(HomeActions.dataLoaded)
    }
}
