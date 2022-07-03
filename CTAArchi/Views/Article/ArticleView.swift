import SwiftUI
import Kingfisher

struct ArticleView: View {

    let title: String?
    let text: String?
    let author: String?
    let date: String?
    let imageUrlString: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 16) {
                    KFImage.url(URL(string: imageUrlString ?? ""))
                        .resizable()
                        .frame(width: 60, height: 60)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("Author: \(author ?? "")")
                            .font(.system(size: 14).bold()).lineLimit(1)
                        Spacer()
                        Text("Creation date: \(date ?? "")")
                            .font(.system(size: 14).bold()).lineLimit(1)
                        Spacer()
                    }
                    Spacer()
                }
                Spacer(minLength: 40)
                Text(text ?? "")
                    .font(.system(size: 18))
            }
            .padding()
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(title ?? "")
        }
    }
}
