//
//  LogMiddleware.swift
//  HelloRedux
//
//  Created by artembolotov on 07.09.2023.
//

import Foundation

func logMiddleware() -> Middleware<AppState> {
    return { state, action, dispath in
        print("Log middleware")
    }
}
