//
//  ContentView.swift
//  HelloRedux
//
//  Created by artembolotov on 06.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: Store<AppState>
    @State private var isPresented = false
    
    struct Props {
        let counter: Int
        let onIncrement: () -> Void
        let onDecrement: () -> Void
        let onAdd: (Int) -> Void
        let onAsyncIncrement: () -> Void
    }
    
    private func map(state: CounterState) -> Props {
        Props(counter: state.counter, onIncrement: {
            store.dispatch(action: IncrementAction())
        }, onDecrement: {
            store.dispatch(action: DecrementAction())
        }, onAdd: { value in
            store.dispatch(action: AddAction(value: value))
        }, onAsyncIncrement: {
            store.dispatch(action: IncrementActionAsync())
        })
    }
    
    var body: some View {
        let props = map(state: store.state.counterState)
        VStack {
            Spacer()
            
            Text("\(props.counter)")
                .padding()
            
            Group {
                Button("Increment", action: props.onIncrement)
                Button("Decrement", action: props.onDecrement)
                Button("Add") {
                    props.onAdd(100)
                }
                Button("Async increment", action: props.onAsyncIncrement)
            }
            
            Spacer()
            
            Button("Add Task") {
                isPresented = true
            }
        }
        .padding()
        .sheet(isPresented: $isPresented) {
            AddTaskView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let store = Store(reducer: appReducer, state: AppState(), middlewares: [logMiddleware(), incrementMiddleware()])
    
    static var previews: some View {
        
        ContentView()
            .environmentObject(store)
    }
}
