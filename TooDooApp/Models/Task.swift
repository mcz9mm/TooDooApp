//
//  Task.swift
//  TooDoo
//
//  Created by kaoru matarai on 2024/05/16.
//

import Foundation

struct Task: Identifiable {
  var id = UUID()
  var title: String
  var isCompleted: Bool
}
