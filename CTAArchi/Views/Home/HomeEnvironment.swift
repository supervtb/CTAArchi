import ComposableArchitecture

struct HomeEnvironment {
    
    var apiClient: APIClient
    var dbClient: DBClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}
