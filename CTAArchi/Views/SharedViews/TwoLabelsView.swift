import SwiftUI
import Kingfisher

struct TwoLabelsView: View {

    let title: String?
    let subtitle: String?
    let date: String?
    let imageUrlString: String?

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            KFImage.url(URL(string: imageUrlString ?? ""))
                .resizable()
                .frame(width: 60, height: 60)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            VStack(alignment: .leading) {
                Text(title ?? "")
                    .font(.system(size: 24).bold())
                    .lineLimit(2)
                Spacer(minLength: 30)
                Text(subtitle ?? "")
                    .font(.system(size: 18))
                    .lineLimit(2)
                Spacer()
                Text(date ?? "")
                    .font(.system(size: 12).italic())
                Spacer()
            }
            Spacer()
        }
        .padding()
        .border(.gray, width: 0.5)
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray, lineWidth: 0.5))
    }
}
