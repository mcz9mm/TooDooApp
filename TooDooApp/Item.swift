//
//  Item.swift
//  TooDooApp
//
//  Created by kaoru matarai on 2024/05/17.
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
