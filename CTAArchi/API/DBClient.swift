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
            return Effect.run { subscriber in
                let cancelable = AnyCancellable {}
                Firestore.firestore().collection("lessons").order(by: "date").addSnapshotListener { querySnapshot, error in
                    guard let documents = querySnapshot?.documents.reversed() else {
                        return
                    }
                    do {
                        let lessons: [Lesson] = try documents.map { try $0.data(as: Lesson.self) }
                        subscriber.send(lessons)
                    } catch {
                        subscriber.send(nil)
                    }
                }
                return cancelable
            }
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
