//
//  ContentView.swift
//  TooDoo
//
//  Created by kaoru matarai on 2024/05/16.
//

import SwiftUI
import SwiftData

struct TopPage: View {
  @State private var tasks: [Task] = []
  @State private var newTaskTitle: String = ""
  @FocusState var focus: Bool

  @State private var isShowingEditModal = false
  @State private var taskToEdit: Task?

  @State private var toast: Toast? = nil

  var body: some View {
    NavigationView {
      VStack {
        if tasks.isEmpty {
          VStack {
            Text("タスクが空です")
              .font(.title2)
              .foregroundColor(.gray)
              .padding(.bottom, 30)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color(UIColor.systemGroupedBackground))
        } else {
          List {
            if (!incompleteTasks.isEmpty) {
              Section(header: Text("これからやるやつ")
                .font(.subheadline)
                .listRowInsets(EdgeInsets())
                .padding(.top, 20).padding(.bottom, 8)) {
                  ForEach(incompleteTasks) { task in
                    TaskRow(task: task, toggleTaskCompletion: toggleTaskComplete)
                      .swipeActions(edge: .trailing) {
                        Button {
                          deleteTask(task)
                        } label: {
                          Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                        Button {
                          editTask(task)
                        } label: {
                          Text("編集")
                        }
                        .tint(.yellow)
                      }
                  }
                }
            }

            if (!completedTasks.isEmpty) {
              Section(header: Text("完了したやつ")
                .font(.subheadline)
                .listRowInsets(EdgeInsets())
                .padding(.top, 20).padding(.bottom, 8)) {
                  ForEach(completedTasks) { task in
                    TaskRow(task: task, toggleTaskCompletion: toggleTaskComplete)
                      .swipeActions(edge: .trailing) {
                        Button {
                          deleteTask(task)
                        } label: {
                          Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                        Button {
                          editTask(task)
                        } label: {
                          Text("編集")
                        }
                        .tint(.yellow)
                      }
                  }
                }
            }
          }
          .listStyle(InsetGroupedListStyle())
        }
        HStack {
          TextField("新しいタスク", text: $newTaskTitle)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding()
            .toolbar{
              ToolbarItem(placement: .keyboard){
                HStack{
                  Spacer()
                  Button("Close"){
                    self.focus = false
                  }
                }
              }
            }
            .focused(self.$focus)

          Button(action: {
            if (newTaskTitle.isEmpty) {
              return
            }
            hideKeyboard()
            toast = Toast(style: .success, message: "タスクを追加しました。")
            addTask()
            UserUxManager.addHF()
          }) {
            Text("+")
              .font(.system(size: 16, weight: Font.Weight.bold))
              .foregroundColor(.white)
              .padding(.horizontal, 16).padding(.vertical, 12)
              .background(Color.blue)
              .cornerRadius(8)
          }
          .padding(.trailing, 8)
        }
        .padding(.horizontal, 4)
      }
      .navigationTitle("TooDoo☕️")
      .sheet(isPresented: $isShowingEditModal) {
        EditTaskView(task: $taskToEdit) { updatedTask in
          updateTask(updatedTask)
        }
      }
    }.toastView(toast: $toast)
  }

  private var incompleteTasks: [Task] {
    tasks.filter { !$0.isCompleted }
  }

  private var completedTasks: [Task] {
    tasks.filter { $0.isCompleted }
  }

  private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }

  private func addTask() {
    withAnimation {
      let newTask = Task(title: newTaskTitle, isCompleted: false)
      tasks.append(newTask)
      newTaskTitle = ""
    }
  }

  private func toggleTaskComplete(_ task: Task) {
    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
      withAnimation {
        tasks[index].isCompleted.toggle()
      }
    }
  }

  private func deleteTask(_ task: Task) {
    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
      tasks.remove(at: index)
    }
  }

  private func editTask(_ task: Task) {
    UserUxManager.tapHF()
    taskToEdit = task
    isShowingEditModal = true
  }

  private func updateTask(_ updatedTask: Task) {
    if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
      tasks[index] = updatedTask
    }
    self.isShowingEditModal = false
  }
}
