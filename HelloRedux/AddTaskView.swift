//
//  AddTaskView.swift
//  HelloRedux
//
//  Created by artembolotov on 07.09.2023.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var store: Store<AppState>
    @State private var name = ""
    
    struct Props {
        let tasks: [Task]
        let onTaskAdded: (Task) -> ()
    }
    
    private func map(state: TaskState) -> Props {
        Props(tasks: state.tasks, onTaskAdded: { task in
            store.dispatch(action: AddTaskAction(task: task))
        })
    }
    
    var body: some View {
        let props = map(state: store.state.taskState)
        
        NavigationView {
            VStack {
                TextField("Enter task name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button("Add Task") {
                    let task = Task(title: name)
                    props.onTaskAdded(task)
                    
                    name = ""
                }
                .disabled(name.isEmpty)
                
                List(props.tasks) { task in
                    Text(task.title)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Tasks")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static let store = Store(reducer: appReducer, state: AppState())
    
    static var previews: some View {
        AddTaskView()
            .environmentObject(store)
    }
}
