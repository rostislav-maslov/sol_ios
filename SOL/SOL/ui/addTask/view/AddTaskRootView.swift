//
//  AddTaskComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI
import AlertToast

struct AddTaskRootView: View {
    @EnvironmentObject var model: AddTaskViewModel
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var slotStore: SlotStore
    
    @State var deadlineViewDate = Date()
    
    var body: some View {
        
        Group{
            if model.state == .HIDDEN {
                EmptyView()
            }else {
                ZStack{
                    if self.model.state != AddTaskState.PLACEHOLDER {
                        BackgroundView(didTouch: model.touchBackground)
                    }
                    
                    if self.model.state == AddTaskState.TEXT {
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(SolColor.colors().addTask.addTaskBackground)
                                .frame(height: 34, alignment: .center)
                        }.ignoresSafeArea()
                    }
                    
                    VStack {
                        Spacer()
                        Spacer().frame(width: 0, height: 0, alignment: .center)
                        if self.model.state == AddTaskState.PLACEHOLDER {
                            PlaceholderTaskView(model: model)
                        }
                        if self.model.state == AddTaskState.TEXT && self.model.showDeadline == false{
                            AddTaskTextView(model: model)
                        }
                        Spacer().frame(width: 0, height: 0, alignment: .center)
                    }
                    
                    PlanningSlotsView(model: model.planningSlotsModel, onClose: { drafts in
                        model.task.slots = drafts
                        model.goToText()
                    })
                    
                    ChooseDeadlineView(
                        isPresented: $model.showDeadline,
                        date: $model.task.deadline,
                        onClear: model.goToText,
                        onSubmit: model.goToText
                    )
                    
                }
                .toast(isPresenting: $model.showToastSuccessCreate){
                    AlertToast(
                        displayMode: .hud,
                        type: .regular,
                        title: "Task did create 👍",
                        subTitle: "Take a look on inbox space"
                    )
                }
                .onAppear(perform: {
                    model.spaceStore = spaceStore
                    model.taskStore = taskStore
                    model.planningSlotsModel.slotStore = slotStore
                    model.planningSlotsModel.taskStore = taskStore
                    model.planningSlotsModel.spaceStore = spaceStore
                    model.planningSlotsModel.type = .TASK_CREATE
                }).onDisappear {
                    
                }
            }
        }
    }
}

//struct AddTaskRootView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskRootView( spaceId:"", parentTaskId: "")
//            .preferredColorScheme(.light)
//        
//    }
//}
