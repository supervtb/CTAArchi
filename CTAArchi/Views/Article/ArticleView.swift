import SwiftUI
import Kingfisher
import ComposableArchitecture

struct ArticleView: View {

    @State var firstAppear: Bool = true

    let store: Store<ArticleState, ArticleActions>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            let lesson = viewStore.lesson
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 16) {
                        KFImage.url(URL(string: lesson?.image ?? ""))
                            .resizable()
                            .frame(width: 60, height: 60)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Author: \(lesson?.author ?? "")")
                                .font(.system(size: 14).bold()).lineLimit(1)
                            Spacer()
                            Text("Creation date: \(lesson?.date?.formatted() ?? "")")
                                .font(.system(size: 14).bold()).lineLimit(1)
                            Spacer()
                        }
                        Spacer()
                    }
                    Spacer(minLength: 40)
                    Text(lesson?.description ?? "")
                        .font(.system(size: 18))
                }
                .padding()
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle(lesson?.title ?? "")
            }
            .onAppear {
                if firstAppear {
                    viewStore.send(.loadData)
                    self.firstAppear = false
                }
            }
        }
    }
}
