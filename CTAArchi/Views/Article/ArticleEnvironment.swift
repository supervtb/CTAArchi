import ComposableArchitecture

struct ArticleEnvironment {

    var apiClient: APIClient
    var dbClient: DBClient
    var mainQueue: AnySchedulerOf<DispatchQueue>

    static let live = Self(apiClient: .live, dbClient: .live, mainQueue: .main)
}
