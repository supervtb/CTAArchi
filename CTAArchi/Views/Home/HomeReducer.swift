import ComposableArchitecture

let homeReducer = Reducer<HomeState, HomeActions, HomeEnvironment> { state, action, environment in
    switch action {
    case let .dataLoaded(.success(response)):
        state.isLoading = false
        state.lessons = response.map({ IdentifiedArrayOf(uniqueElements: $0) })
        return .none
    case .dataLoaded(.failure):
        state.isLoading = false
        return .none
    case .loadData:
        state.isLoading = true
        return environment.apiClient
            .fetchLessons()
            .receive(on: environment.mainQueue)
            .catchToEffect(HomeActions.dataLoaded)
    }
}
