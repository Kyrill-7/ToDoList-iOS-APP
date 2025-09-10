//
//  Item.swift
//  ToDoList
//
//  Created by Dhruv Chaudhari on 11/09/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
