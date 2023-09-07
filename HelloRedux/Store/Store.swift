//
//  Store.swift
//  HelloRedux
//
//  Created by artembolotov on 06.09.2023.
//

import Foundation

protocol ReduxState { }
protocol Action { }

typealias Dispatcher = (Action) -> Void

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<State: ReduxState> = (State, Action, @escaping Dispatcher) -> Void

struct AppState: ReduxState {
    var counterState = CounterState()
    var taskState = TaskState()
}

struct CounterState: ReduxState {
    var counter = 0
}

struct TaskState: ReduxState {
    var tasks = [Task]()
}

struct IncrementAction: Action { }
struct IncrementActionAsync: Action { }
struct DecrementAction: Action { }
struct AddAction: Action {
    let value: Int
}

struct AddTaskAction: Action {
    let task: Task
}

@MainActor
final class Store<StoreState: ReduxState>: ObservableObject {
    
    @Published var state: StoreState
    
    var reducer: Reducer<StoreState>
    var middlewares: [Middleware<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState, middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        state = reducer(state, action)
        
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}
