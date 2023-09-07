//
//  IncrementMiddleware.swift
//  HelloRedux
//
//  Created by artembolotov on 07.09.2023.
//

import Foundation

func incrementMiddleware() -> Middleware<AppState> {
    return { state, action, dispatch in
        switch action {
        case _ as IncrementActionAsync:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dispatch(IncrementAction())
            }
        default:
            break
        }
    }
}
