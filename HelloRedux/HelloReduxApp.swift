//
//  HelloReduxApp.swift
//  HelloRedux
//
//  Created by artembolotov on 06.09.2023.
//

import SwiftUI

@main
struct HelloReduxApp: App {
    
    @StateObject var store = Store(reducer: appReducer, state: AppState(), middlewares: [logMiddleware(), incrementMiddleware()])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
