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
    var taskId: String
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    
    @ObservedObject var model: TaskViewModel
    @EnvironmentObject var navigationStack: NavigationStack
    
    init(taskId: String){
        self.taskId = taskId
        self.model = TaskViewModel(taskId: taskId)                    
    }
    
    var body: some View {
        
        ZStack {            
            content
            SolNavigationView()            
            
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
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)        
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

