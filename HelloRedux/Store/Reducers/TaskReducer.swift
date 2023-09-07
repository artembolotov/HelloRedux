//
//  TaskReducer.swift
//  HelloRedux
//
//  Created by artembolotov on 06.09.2023.
//

import Foundation

func TaskReducer(_ state: TaskState, _ action: Action) -> TaskState {
    
    var state = state
    
    switch action {
    case let action as AddTaskAction:
        state.tasks.append(action.task)
    default:
        break
    }
    
    return state
}
