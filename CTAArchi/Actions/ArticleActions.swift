enum ArticleActions: Equatable {
    case loadData
    case dataLoaded(Result<Lesson?, APIClient.Failure>)
}
