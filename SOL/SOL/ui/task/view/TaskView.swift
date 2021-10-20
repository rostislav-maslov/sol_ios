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
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    
    @StateObject var model: TaskViewModel = TaskViewModel()
    
    
    @State var goToTaskView = false
    @State var goToTaskId = ""

    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    
    init(spaceId: String, taskId: String){
        self.spaceId = spaceId
        self.taskId = taskId
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    var body: some View {
        
        ZStack {            
            content
            
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {
                    taskStore.tasks[taskId]!.icon.data = model.emoji
                    model.stopEditIcon = true
                    taskStore.saveTitleIcon(taskId: taskId)
                    model.emojiTextField?.endEditing(false)
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                })
            }
            
            NavigationLink(
                destination: TaskView(spaceId: self.spaceId, taskId: goToTaskId),
                isActive: $goToTaskView,
                label:{
                    
                })
                .frame(width: 0, height: 0)
                .buttonStyle(PlainButtonStyle())
        }
        .preferredColorScheme(.light)
        .navigationTitle(taskStore.tasks[taskId]?.title ?? "")
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear(perform: {
            self.model.taskId = taskId
            self.model.taskStore = taskStore
            self.model.emoji = taskStore.tasks[taskId]!.icon.data
            
            self.model.taskStore = taskStore
            self.planningSlotsModel.type = .TASK
            
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

