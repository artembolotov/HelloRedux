//
//  AppReducer.swift
//  HelloRedux
//
//  Created by artembolotov on 06.09.2023.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    
    var state = state
    
    state.counterState = counterReducer(state.counterState, action)
    state.taskState = TaskReducer(state.taskState, action)
    
    return state
}
