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
                        if self.model.state == AddTaskState.PLACEHOLDER {
                            PlaceholderTaskView(model: model)
                        }
                        if self.model.state == AddTaskState.TEXT && self.model.showDeadline == false{
                            AddTaskTextView(model: model)
                        }
                        if self.model.state == AddTaskState.PLANNING{
                            PlanningSlotsView(
                                isPresented: $model.showPlanning,
                                type: PlanningType.TASK_CREATE,
                                delegate: self.model)
                                .colorScheme(ColorScheme.light)
                        }
                    }
                    
                    //PlanningSlotsView(isPdelegate: self.model).colorScheme(ColorScheme.light)
                    
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
                    self.model.spaceStore = spaceStore
                    self.model.taskStore = taskStore
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
