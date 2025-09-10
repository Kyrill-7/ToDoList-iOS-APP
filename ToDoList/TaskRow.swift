import SwiftUI

struct TaskRow: View {
    let task: Task
    let toggle: () -> Void

    var body: some View {
        HStack {
            Button(action: toggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.priority.color)
                    .font(.system(size: 22))
            }
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)
                .animation(.easeInOut, value: task.isCompleted)
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.9))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
        )
        .padding(.vertical, 4)
    }
}
