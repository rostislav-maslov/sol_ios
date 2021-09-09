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
    @ObservedObject var multilineTextFieldModel:MultilineTextFieldModel = MultilineTextFieldModel()
    @State var isTarget:Bool = true
    
    init(model: TaskViewModel){
        self.model = model
        self.multilineTextFieldModel.delegate = model
        NavigationBarHelper.updateHeightDelta()
    }
    
    var body: some View {
        
        ZStack {            
            content
            SolNavigationView()            
            
            if model.bottomButtonType == BottomButtonType.ADD_TASK {
                AddTaskRootView(
                    model: AddTaskViewModel(
                        model.task.spaceId,
                        parentTaskId: model.taskId,
                        taskDidCreated: model.taskDidCreated),
                    parentTitle: $model.task.title)
            }
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {
                    model.saveTitleIcon()
                    model.emojiTextField?.endEditing(false)
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                })
            }
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

