import SwiftUI

struct ContentView: View {
    @StateObject private var store = TaskStore()
    @State private var showingAddTask = false

    var body: some View {
        ZStack {
            // 🌈 Stylish Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // ✨ Floating Gradient Circles
            Circle()
                .fill(Color.purple.opacity(0.25))
                .blur(radius: 80)
                .offset(x: -100, y: -200)

            Circle()
                .fill(Color.blue.opacity(0.25))
                .blur(radius: 100)
                .offset(x: 150, y: 250)

            Circle()
                .fill(Color.mint.opacity(0.2))
                .blur(radius: 120)
                .offset(x: -150, y: 300)

            // 📝 Main Task List
            NavigationView {
                List {
                    ForEach(Priority.allCases) { priority in
                        Section(header: Text(priority.rawValue)
                            .font(.headline)
                            .foregroundColor(priority.color)) {
                            ForEach(store.tasks.filter { $0.priority == priority }) { task in
                                TaskRow(task: task, toggle: { store.toggle(task) })
                            }
                            .onDelete { indexSet in
                                store.remove(at: indexSet)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden) // transparent background for list
                .background(Color.clear) // keep background visible
                .navigationTitle("✨ To-Do List")
                .toolbar {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.purple)
                            .shadow(radius: 3)
                    }
                }
                .sheet(isPresented: $showingAddTask) {
                    AddTaskView(store: store)
                }
            }
        }
    }
}
