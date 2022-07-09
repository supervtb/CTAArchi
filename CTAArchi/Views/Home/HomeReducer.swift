import ComposableArchitecture

let homeReducer =
articleReducer.optional()
    .pullback(state: \Identified.value, action: .self, environment: { $0 })
    .optional()
    .pullback(
        state: \HomeState.selection,
        action: /HomeActions.article,
        environment: { _ in ArticleEnvironment(apiClient: .live, mainQueue: .main) }
    )
    .combined(
        with: Reducer<
        HomeState, HomeActions, HomeEnvironment
        > { state, action, environment in
            enum CancelId {}
            switch action {
            case let .dataLoaded(.success(response)):
                state.isLoading = false
                state.lessons = response.map({ IdentifiedArrayOf(uniqueElements: $0) }) ?? []
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
            case .article(_):
                return .none
            case .setNavigation(selection: let selection):
                state.selection = Identified(nil, id: selection ?? "")

                return Effect(value: .setNavigationSelectionCompleted)
                    .delay(for: 0, scheduler: environment.mainQueue)
                    .eraseToEffect()
                    .cancellable(id: CancelId.self)
            case .setNavigationSelectionCompleted:
                guard let id = state.selection?.id else { return .none }
                state.selection?.value = ArticleState(lessonId: state.lessons[id: id]?.id ?? "")
                return .none
            }
        }
    )
