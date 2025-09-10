import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: TaskStore
    @State private var title = ""
    @State private var priority = Priority.medium

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add New Task")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                TextField("Enter task title...", text: $title)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .shadow(radius: 2)

                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases) { p in
                        Text(p.rawValue).tag(p)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.teal.opacity(0.2), Color.mint.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newTask = Task(title: title, priority: priority)
                        store.add(newTask)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
