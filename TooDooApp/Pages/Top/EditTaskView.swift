//
//  EditTaskView.swift
//  TooDoo
//
//  Created by kaoru matarai on 2024/05/16.
//

import SwiftUI

struct EditTaskView: View {
  @Binding var task: Task?
  var onSave: (Task) -> Void

  @State private var title: String = ""

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("タスク名")
          .font(.subheadline)
          .listRowInsets(EdgeInsets())
          .padding(.top, 20).padding(.bottom, 8)) {
            TextField("タイトルを入力", text: $title)
              .onAppear {
                if let task = task {
                  title = task.title
                }
              }
          }
      }
      .navigationTitle("タスクを編集")
      .navigationBarItems(trailing: Button("保存") {
        if let task = task {
          UserUxManager.tapHF()
          task.title = title
          onSave(task)
        }
      })
    }
  }
}
