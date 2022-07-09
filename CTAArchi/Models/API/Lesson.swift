import SwiftUI

struct Lesson: Codable, Identifiable, Equatable {
    
    var id = UUID().uuidString
    let title: String?
    let description: String?
    let author: String?
    let image: String?
    let date: Date?
}
