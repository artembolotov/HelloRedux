//
//  Task.swift
//  HelloRedux
//
//  Created by artembolotov on 06.09.2023.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    let title: String
}
