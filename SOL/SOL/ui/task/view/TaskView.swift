//
//  TaskView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation
import SwiftUI
import NavigationStack

struct TaskView: View {
    @ObservedObject  var model: TaskViewModel
    @EnvironmentObject var navigationStack: NavigationStack
  
    var body: some View {
        
        ZStack {            
            content
            SolNavigationView()
            AddTaskRootView(
                model: AddTaskViewModel(
                    model.task.spaceId,
                    parentTaskId: model.taskId,
                    taskDidCreated: model.taskDidCreated),
                parentTitle: $model.task.title)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)        
        .onAppear(perform: {
            self.model.load()
        })
    }           
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(model: TaskViewModel(task: TaskEntity.forRender()))
    }
}

