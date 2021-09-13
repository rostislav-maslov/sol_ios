//
//  AddTaskComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

//
//func stateComponent(_ keyboardResponder: KeyboardResponder) -> AddTaskState{
//    if keyboardResponder.currentHeight != 0.0 {
//        return AddTaskState.TEXT
//    }
//    
//    return AddTaskState.PLACEHOLDER
//    //    return StateTask.ADD_TASK
//}
//
//func textFieldBackground(_ kr: KeyboardResponder) -> Color{
//    return stateComponent(kr) == AddTaskState.PLACEHOLDER  ?
//        Color.white : 
//        Color(CGColor(red: 202/255, green: 206/255, blue: 212/255, alpha: 1.0))
//}

struct AddTaskRootView: View {
    var spaceId: String?
    var parentTaskId: String?
    
    @ObservedObject var model: AddTaskViewModel
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
        
    init(spaceId: String?, parentTaskId: String?, taskDidCreated:  @escaping (() -> Void)){
        self.spaceId = spaceId
        self.parentTaskId = parentTaskId
        self.model = AddTaskViewModel(spaceId, parentTaskId: parentTaskId, taskDidCreated: taskDidCreated)
    }
    
    var body: some View {
        ZStack{
            if self.model.state != AddTaskState.PLACEHOLDER {
                BackgroundView(didTouch: model.touchBackground)
            }
            
            if self.model.state == AddTaskState.TEXT {
                
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(SolColor.colors().addTask.addTaskBackground)
                        .frame(width: .infinity, height: 34, alignment: .center)
                }.ignoresSafeArea()
            }
            VStack {
                Spacer()
                    if self.model.state == AddTaskState.PLACEHOLDER {
                        PlaceholderTaskView(model: model)
                    }
                    if self.model.state == AddTaskState.TEXT ||
                        self.model.state == AddTaskState.DEADLINE{
                        AddTaskTextView(model: model)
                    }
                    if self.model.state == AddTaskState.PLANNING{
                        ChooseEventTimeComponent(model: model).colorScheme(ColorScheme.light)
                    }                
                                                                
                EmptyView().sheet(
                    isPresented: $model.sheets.deadline,
                    onDismiss: {
                        model.goToText()                        
                    },
                    content: {
                        ChooseDeadlineView().colorScheme(.light)
                    })
                
            }
        }.onAppear(perform: {
            self.model.spaceStore = spaceStore
            self.model.taskStore = taskStore
        })
    }
}

//struct AddTaskRootView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskRootView( spaceId:"", parentTaskId: "")
//            .preferredColorScheme(.light)
//        
//    }
//}
