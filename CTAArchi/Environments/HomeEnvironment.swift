import ComposableArchitecture

struct HomeEnvironment {
    
    var apiClient: APIClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}
