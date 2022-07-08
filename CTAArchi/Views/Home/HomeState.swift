import SwiftUI

struct HomeState: Equatable {

    var lessons: [Lesson]?
    var isLoading = false

    static func == (lhs: HomeState, rhs: HomeState) -> Bool {
        return lhs.lessons.hashValue == rhs.lessons.hashValue
    }
}
