import Combine
import ComposableArchitecture

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    .init { state, action, _ in
        switch action {
        case .onAppear:
            state = .init()
            return .none
        default:
            return .none
        }
    }, homeReducer.pullback(state: \.home, action: /RootAction.home, environment: { .init(apiClient: $0.apiClient, mainQueue: $0.mainQueue) })
)
.debug()
.signpost()
