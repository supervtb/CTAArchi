enum HomeActions: Equatable {
    case loadData
    case dataLoaded(Result<[Lesson]?, DBClient.Failure>)
    case article(ArticleActions)
    case setNavigation(selection: String?)
    case setNavigationSelectionCompleted
}
