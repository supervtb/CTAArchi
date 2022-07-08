import ComposableArchitecture

struct ArticleEnvironment {

    var apiClient: APIClient
    var mainQueue: AnySchedulerOf<DispatchQueue>

    static let live = Self(apiClient: .live, mainQueue: .main)
}
