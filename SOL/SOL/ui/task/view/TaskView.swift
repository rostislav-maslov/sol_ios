//
//  TaskView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation
import SwiftUI

struct TaskView: View {
    @ObservedObject  var model: TaskViewModel
        
    var body: some View {
        
        ZStack {            
            TaskContentView()
            SolNavigationView()
            AddTaskRootView(model: AddTaskViewModel("", parentTaskId: ""), parentTitle: $model.task.title)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        
        .onAppear(perform: {
            
        })
    }           
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(model: TaskViewModel(task: TaskEntity.forRender()))
    }
}

