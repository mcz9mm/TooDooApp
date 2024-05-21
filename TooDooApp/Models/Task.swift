//
//  Task.swift
//  TooDoo
//
//  Created by kaoru matarai on 2024/05/16.
//

import Foundation
import SwiftData

@Model
final class Task: Identifiable {
  var id = UUID()
  var title: String
  var isCompleted: Bool

  init(id: UUID = UUID(), title: String, isCompleted: Bool) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
  }
}
