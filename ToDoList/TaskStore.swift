import Foundation
import SwiftUI

class TaskStore: ObservableObject {
    @Published private(set) var tasks: [Task] = []
    private let saveKey = "tasks.json"

    init() { load() }

    func add(_ task: Task) {
        withAnimation { tasks.append(task) }
        save()
    }

    func toggle(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            withAnimation { tasks[index].isCompleted.toggle() }
            save()
        }
    }

    func remove(at offsets: IndexSet) {
        withAnimation { tasks.remove(atOffsets: offsets) }
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(tasks)
            let url = getDocumentsDirectory().appendingPathComponent(saveKey)
            try data.write(to: url)
        } catch {
            print("Failed to save tasks: \(error)")
        }
    }

    private func load() {
        let url = getDocumentsDirectory().appendingPathComponent(saveKey)
        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
