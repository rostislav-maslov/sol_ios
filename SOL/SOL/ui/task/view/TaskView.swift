//
//  TaskView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation
import SwiftUI

struct TaskView: View {
    var spaceId: String
    var taskId: String
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    
    @ObservedObject var model: TaskViewModel
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    
    init(spaceId: String, taskId: String){
        self.spaceId = spaceId
        self.taskId = taskId
        self.model = TaskViewModel(taskId: taskId)
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    var body: some View {
        
        ZStack {            
            content
            //SolNavigationView()            
            
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {
                    taskStore.saveTitleIcon(taskId: taskId)
                    model.emojiTextField?.endEditing(false)
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                })
            }
            PlanningSlotsView(
                delegate: self.model,
                isPresented: $model.showPlanning,
                type: PlanningType.VIEW)
                .colorScheme(ColorScheme.light)
        }
        .preferredColorScheme(.light)
        .navigationTitle(taskStore.tasks[taskId]?.title ?? "")
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear(perform: {
            self.model.taskStore = taskStore
            self.addTaskModel.changeView(spaceId: spaceId, taskId: taskId, taskDidCreated: model.taskDidCreated)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.taskStore.syncTask(taskId: taskId)
            }
        })
    }           
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(model: TaskViewModel(task: TaskEntity.forRender()))
//    }
//}

