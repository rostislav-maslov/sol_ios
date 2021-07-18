//
//  AddTaskComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI


func stateComponent(_ keyboardResponder: KeyboardResponder) -> AddTaskState{
    if keyboardResponder.currentHeight != 0.0 {
        return AddTaskState.TEXT
    }
    
    return AddTaskState.PLACEHOLDER
    //    return StateTask.ADD_TASK
}

func textFieldBackground(_ kr: KeyboardResponder) -> Color{
    return stateComponent(kr) == AddTaskState.PLACEHOLDER  ?
        Color.white : 
        Color(CGColor(red: 202/255, green: 206/255, blue: 212/255, alpha: 1.0))
}

struct AddTaskRootView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var model:AddTaskViewModel = AddTaskViewModel()
    //@ObservedObject var kr = KeyboardResponder()
    
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
                
                VStack {
                    HStack {
                        ZStack{
                            if self.model.state == AddTaskState.PLACEHOLDER {
                                PlaceholderTaskView(model: model)
                            }
                            if self.model.state == AddTaskState.TEXT ||
                                self.model.state == AddTaskState.DEADLINE{
                                AddTaskTextView(model: model)
                                //                                    .sheet(isPresented: $model.sheetStatus.days, content: {
                                //                                        Text("days")
                                //                                    }).colorScheme(ColorScheme.light)
                                //
                                //                                    .sheet(isPresented: $model.sheetStatus.notification, content: {
                                //                                        Text("notification")
                                //                                    }).colorScheme(ColorScheme.light)
                                //
                                //                                    .sheet(isPresented: $model.sheetStatus.repeatVar, content: {
                                //                                        Text("repeatVar")
                                //                                    }).colorScheme(ColorScheme.light)
                            }
                            if self.model.state == AddTaskState.PLANNING{
                                ChooseEventTimeComponent(model: model).colorScheme(ColorScheme.light)
                            }
                        }
                    }
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
        }
    }
}

struct AddTaskRootView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskRootView()
            .preferredColorScheme(.light)
        
    }
}
