import Combine
import ComposableArchitecture
import FirebaseFirestoreSwift
import FirebaseFirestore

struct DBClient {

    var fetchLessons: () -> Effect<[Lesson]?, Failure>
    var fetchLesson: (String) -> Effect<Lesson?, Failure>

    struct Failure: Error, Equatable {}
}

extension DBClient {

    static let live = Self(
        fetchLessons: {
            Effect.task {
                let data: [Lesson] = try await Firestore.firestore()
                    .collection("lessons")
                    .getDocuments()
                    .documents
                    .map({ try $0.data(as: Lesson.self) })
                return data
            }
            .mapError { _ in Failure() }
            .eraseToEffect()
        }, fetchLesson: { id in
            Effect.task {
                let data: Lesson = try await Firestore.firestore()
                    .collection("lessons").whereField("id", in: [id])
                    .getDocuments()
                    .documents.first
                    .map({ try $0.data(as: Lesson.self) })!
                return data
            }
            .mapError { _ in Failure() }
            .eraseToEffect()
        }
    )
}
