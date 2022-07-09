import SwiftUI
import Kingfisher
import ComposableArchitecture

struct ArticleView: View {

    @State var firstAppear: Bool = true

    let store: Store<ArticleState, ArticleActions>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in

            let lesson = viewStore.lesson
            
            if lesson == nil {
                ProgressView()
                    .onAppear {
                        if firstAppear {
                            viewStore.send(.loadData)
                            self.firstAppear = false
                        }
                    }
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top, spacing: 16) {
                            KFImage.url(URL(string: viewStore.lesson?.image ?? ""))
                                .resizable()
                                .frame(width: 60, height: 60)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            VStack(alignment: .leading) {
                                Spacer()
                                Text("Author: \(viewStore.lesson?.author ?? "")")
                                    .font(.system(size: 14).bold()).lineLimit(1)
                                Spacer()
                                Text("Creation date: \(viewStore.lesson?.date?.formatted() ?? "")")
                                    .font(.system(size: 14).bold()).lineLimit(1)
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer(minLength: 40)
                        Text(viewStore.lesson?.description ?? "")
                            .font(.system(size: 18))
                    }
                    .padding()
                    .navigationTitle(viewStore.lesson?.title ?? "")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button {
                                viewStore.send(.toggleFavorite)
                            } label: {
                                Image(systemName: viewStore.isFavorite ? "star.fill" : "star")
                                    .foregroundColor(Color("accent"))
                            }
                        }
                    }
                }
            }
        }
    }
}
