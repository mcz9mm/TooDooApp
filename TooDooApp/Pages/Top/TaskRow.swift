//
//  TaskRow.swift
//  TooDoo
//
//  Created by kaoru matarai on 2024/05/16.
//

import SwiftUI

struct TaskRow: View {
  var task: Task
  var toggleTaskCompletion: (Task) -> Void

  var body: some View {
    HStack {
      Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundColor(task.isCompleted ? .blue : .gray)
        .padding(.trailing, 8)
      Text(task.title)
      Spacer()
    }
    .contentShape(Rectangle())
    .onTapGesture {
      toggleTaskCompletion(task)
      UserUxManager.tapHF()
    }
  }
}
