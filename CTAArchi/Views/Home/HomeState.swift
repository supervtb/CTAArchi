import SwiftUI

struct HomeState: Equatable {

    var lessons: [Lesson]?

    static func == (lhs: HomeState, rhs: HomeState) -> Bool {
        return lhs.lessons.hashValue == rhs.lessons.hashValue
    }
}
