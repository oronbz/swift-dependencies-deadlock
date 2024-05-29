//
//  Dependencies.swift
//  DependenciesDeadlock
//
//  Created by Oron Ben Zvi on 29/05/2024.
//

import Foundation
import Dependencies

struct Message {
    var read: () -> String
}

extension Message: DependencyKey {
    static var liveValue: Self = .init { "This is a message" }
}

extension DependencyValues {
    var message: Message {
        get { self[Message.self] }
        set { self[Message.self] = newValue }
    }
}
