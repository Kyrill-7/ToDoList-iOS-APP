import SwiftUI

enum Priority: String, Codable, CaseIterable, Identifiable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .high: return Color.pink
        case .medium: return Color.orange
        case .low: return Color.green
        }
    }
}

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var priority: Priority
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, priority: Priority, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.priority = priority
        self.isCompleted = isCompleted
    }
}
