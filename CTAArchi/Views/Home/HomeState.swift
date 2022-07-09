import SwiftUI
import ComposableArchitecture

struct HomeState: Equatable {

    var lessons: IdentifiedArrayOf<Lesson> = []
    var selection: Identified<Lesson.ID, ArticleState?>?
    var isLoading = false
}
