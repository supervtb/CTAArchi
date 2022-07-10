enum ArticleActions: Equatable {
    case loadData
    case dataLoaded(Result<Lesson?, DBClient.Failure>)
    case toggleFavorite
}
