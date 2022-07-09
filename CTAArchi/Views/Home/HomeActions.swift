enum HomeActions: Equatable {
    case loadData
    case dataLoaded(Result<[Lesson]?, APIClient.Failure>)
    case article(ArticleActions)
    case setNavigation(selection: String?)
    case setNavigationSelectionCompleted
}
