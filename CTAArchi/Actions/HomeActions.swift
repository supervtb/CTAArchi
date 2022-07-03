enum HomeActions: Equatable {
    case loadData
    case dataLoaded(Result<[Lesson]?, APIClient.Failure>)
}
