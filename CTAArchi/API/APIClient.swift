import Combine
import ComposableArchitecture

struct APIClient {

    var fetchLessons: () -> Effect<[Lesson]?, Failure>
    var fetchLesson: (String) -> Effect<Lesson?, Failure>


    struct Failure: Error, Equatable {}
}

extension APIClient {

    static let live = Self(
        fetchLessons: {
            Effect.task {
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "https://62c0c0b6d40d6ec55cd57047.mockapi.io/api/v1/fact")!)
                return try? JSONDecoder().decode([Lesson].self, from: data)
            }
            .mapError { _ in Failure() }
            .eraseToEffect()
        }, fetchLesson: { id in
            Effect.task {
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "https://62c0c0b6d40d6ec55cd57047.mockapi.io/api/v1/fact/\(id)")!)
                return try? JSONDecoder().decode(Lesson.self, from: data)
            }
            .mapError { _ in Failure() }
            .eraseToEffect()
        }
    )
}
