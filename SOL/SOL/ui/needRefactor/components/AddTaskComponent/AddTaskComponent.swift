//
//  AddTaskComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

enum StateTask {
    case PLACEHOLDER
    case ADD_TASK
}

func stateComponent(_ keyboardResponder: KeyboardResponder) -> StateTask{
    if keyboardResponder.currentHeight != 0.0 {
        return StateTask.ADD_TASK
    }
    
    return StateTask.PLACEHOLDER
    //    return StateTask.ADD_TASK
}

func textFieldBackground(_ kr: KeyboardResponder) -> Color{
    return stateComponent(kr) == StateTask.PLACEHOLDER  ?
        Color.white : 
        Color(CGColor(red: 202/255, green: 206/255, blue: 212/255, alpha: 1.0))
}

enum AddTaskStatus {
    case INIT
    case OPEN
    case DEADLINE
    case PLANNING
    case NOTIFICATION
    case REPEAT
    
}



class AddTaskComponentViewModel: ObservableObject {
    @Published var status: AddTaskStatus = .OPEN
    @Published var taskText: String = ""
}

struct AddTaskComponent: View {
    @ObservedObject var viewModel = AddTaskComponentViewModel()
    //@ObservedObject var kr = KeyboardResponder()
    @State var showPlanning:Bool = false
    @State var showDeadline:Bool = false
    func didDismiss(){}
    
    var body: some View {
        ZStack{
            if self.viewModel.status != AddTaskStatus.INIT {
                BackgroundForModalComponent {
                    if viewModel.status == .OPEN {
                        viewModel.status = .INIT
                        return
                    }
                    if viewModel.status == .DEADLINE {
                        viewModel.status = .OPEN
                        return
                    }
                    if viewModel.status == .PLANNING {
                        viewModel.status = .OPEN
                        return
                    }
                    if viewModel.status == .NOTIFICATION {
                        viewModel.status = .OPEN
                        return
                    }
                    if viewModel.status == .REPEAT {
                        viewModel.status = .OPEN
                        return
                    }
                    viewModel.status = .INIT
                }
            }
            
            
            if self.viewModel.status == AddTaskStatus.OPEN {
                
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
                            if self.viewModel.status == AddTaskStatus.INIT {
                                PlaceholderTaskComponent(text: $viewModel.taskText) {
                                    viewModel.status = AddTaskStatus.OPEN
                                }
                            }
                            if self.viewModel.status == AddTaskStatus.OPEN {
                                AddTaskModalComponent(status:  $viewModel.status, onChangeStatus: {
                                    if viewModel.status == .DEADLINE {
                                        showPlanning = false
                                        showDeadline = true
                                    }
                                    
                                    if viewModel.status == .PLANNING {
                                        showDeadline = false
                                        showPlanning = true
                                    }
                                })
                                
                                //                                    .sheet(isPresented: $viewModel.sheetStatus.days, content: {
                                //                                        Text("days")
                                //                                    }).colorScheme(ColorScheme.light)
                                //
                                //                                    .sheet(isPresented: $viewModel.sheetStatus.notification, content: {
                                //                                        Text("notification")
                                //                                    }).colorScheme(ColorScheme.light)
                                //
                                //                                    .sheet(isPresented: $viewModel.sheetStatus.repeatVar, content: {
                                //                                        Text("repeatVar")
                                //                                    }).colorScheme(ColorScheme.light)
                                
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                }
                

                EmptyView().sheet(isPresented: $showPlanning, content: {
                    ChooseEventTimeComponent().colorScheme(ColorScheme.light)
                })
                
                EmptyView().sheet(isPresented: $showDeadline, content: {
                    ChooseDeadlineComponent().colorScheme(.light)
                })
                
//                if(viewModel.status == .DEADLINE) {
//                    DeadLineChoose()
//                        .colorScheme(ColorScheme.light)
//                }
            }
        }
    }
}

struct AddTaskComponent_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskComponent()
            .preferredColorScheme(.light)
        
    }
}
