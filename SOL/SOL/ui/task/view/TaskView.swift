//
//  TaskView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation
import SwiftUI

struct TaskView: View {
    var taskId: String
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    
    @ObservedObject var model: TaskViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    
    init(taskId: String){
        self.taskId = taskId
        self.model = TaskViewModel(taskId: taskId)
        UINavigationBar.appearance().titleTextAttributes = [
                   .font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    var body: some View {
        
        ZStack {            
            content
            //SolNavigationView()            
            
            if model.bottomButtonType == BottomButtonType.ADD_TASK {
                AddTaskRootView(spaceId: taskStore.tasks[taskId]?.spaceId, parentTaskId: taskId) {
                    withAnimation {
                        self.model.scrollViewProxy?
                            .scrollTo(
                                "endOfScrollViewTasks",
                                anchor: .bottom)
                    }
                }
            }
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
        .navigationTitle(taskStore != nil ? (taskStore.tasks[taskId]?.title ?? "") : "" )
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear(perform: {
            self.model.taskStore = taskStore
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

