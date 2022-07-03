import Combine
import ComposableArchitecture
import Foundation

struct RootEnvironment {
    
    var uuid: () -> UUID
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var apiClient: APIClient
    
    static let live = Self(uuid: UUID.init, mainQueue: .main, apiClient: .live)
}
