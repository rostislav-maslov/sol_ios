//
//  AddTaskModalComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.06.2021.
//

import SwiftUI


class AddTaskModalViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var state: ViewState = ViewState.NORMAL
    @Published var emoji: String = ""
}

struct AddTaskModalComponent: View {
    @ObservedObject var viewModel = AddTaskModalViewModel()
    @State var text:String = ""
    @State var sheet:Bool = false
    @Binding var status: AddTaskStatus
    var onChangeStatus: () -> Void
//    var planningDidTouch: () -> Void
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(SolColor.colors().addTask.addTaskBackground)
                .cornerRadius(12, corners: [.topLeft, .topRight])
                .frame(width: .infinity, height: 102, alignment: .center)
            
           
            
            VStack{
                HStack{
                    TextField("Type your task", text: $viewModel.title)
                        .font(
                            SolFonts.font(
                                size: 16,
                                weight: Font.Weight.medium,
                                color: SolColor.colors().fontColors.normal))
                        .padding()
                }
                Spacer().frame(width: 0, height: 8, alignment: .center)
                HStack{
                    Spacer().frame(width: 16, height: 8, alignment: .center)
                    
                    IconFieldComponent(placeholder: "", value: $viewModel.emoji, state: $viewModel.state)
                    Spacer().frame(width: 36, height: 8, alignment: .center)
                    HStack {
                       
                        TaskFieldButtonComponent(imageName: "days", title: "planning", choosed: false) {
                            status = AddTaskStatus.PLANNING
                            onChangeStatus()
                        }
                        Spacer().frame(width: 24, height: 0, alignment: .center)
                        TaskFieldButtonComponent(imageName: "notification", title: "notification", choosed: false) {
                            status = .NOTIFICATION
                            onChangeStatus()
                        }
                        Spacer().frame(width: 24, height: 0, alignment: .center)
                        TaskFieldButtonComponent(imageName: "deadline", title: "Deadline", choosed: false) {
                            status = .DEADLINE
                            onChangeStatus()
                        }
                        Spacer().frame(width: 24, height: 0, alignment: .center)
                       
                        TaskFieldButtonComponent(imageName: "repeat", title: "repeat", choosed: false) {
                            status = .REPEAT
                            onChangeStatus()
                        }
                    }
                    Spacer()
                    
                    Image("add_task_submit")
                        .background(SolColor.colors().addTask.taskButtonsColor)
                        .cornerRadius(12.0)
                        .frame(width: 16, height: 16, alignment: .center)
                    Spacer().frame(width: 16, height:0, alignment: .center)
                    
                }
                .frame(width: .infinity, height: 30, alignment: .center)
                Spacer().frame(width: 0.0, height: 8.0, alignment: .center)
                
            }
            
            
            
           
            
        }
    }
}

struct AddTaskModalComponent_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskModalComponent(status: Binding<AddTaskStatus>(get: {
            return .OPEN
        }, set: { (s:AddTaskStatus) in
            
        }), onChangeStatus: {
            
        })
    }
}
