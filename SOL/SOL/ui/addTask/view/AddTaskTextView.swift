//
//  AddTaskModalComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.06.2021.
//

import SwiftUI

struct AddTaskTextView: View {
    @ObservedObject var model:AddTaskViewModel
    @State var stateIcon: ViewState = ViewState.NORMAL
    @State private var titleIsFocused: Field = .firstName
    
    var body: some View {
        ZStack{
            backgroundView
            
            VStack{
                titleField
                Spacer().frame(width: 0, height: 8, alignment: .center)
                HStack{
                    Spacer().frame(width: 16, height: 8, alignment: .center)
                    iconChose
                    Spacer().frame(width: 36, height: 8, alignment: .center)
                    buttonsLine
                    Spacer()
                    
                    submitButton
                    Spacer().frame(width: 16, height:0, alignment: .center)
                    
                }
                .frame(width: .infinity, height: 30, alignment: .center)
                Spacer().frame(width: 0.0, height: 8.0, alignment: .center)
                
            }
        }
        .onAppear(perform: {
            print("AddTaskTextView - did appear")
            
        })
    }
}

extension AddTaskTextView{
    var backgroundView: some View {
        Rectangle()
            .fill(SolColor.colors().addTask.addTaskBackground)
            .cornerRadius(12, corners: [.topLeft, .topRight])
            .frame(width: .infinity, height: 102, alignment: .center)
    }
}

extension AddTaskTextView{
    enum Field {
           case firstName
           case lastName
           case emailAddress
       }
    
    var titleField: some View {
        HStack{
            TextField("Type your task", text: $model.task.title)
                .font(
                    SolFonts.font(
                        size: 16,
                        weight: Font.Weight.medium,
                        color: SolColor.colors().fontColors.normal))
                .padding()                
        }
    }
}

extension AddTaskTextView{
    var iconChose: some View {
        IconFieldComponent(placeholder: "", value: $model.task.emoji, state: $stateIcon)
    }
}

extension AddTaskTextView{
    var buttonsLine: some View {
        HStack {
            TaskFieldButtonComponent(
                imageName: "days",
                title: "planning",
                choosed: false,
                didTouch: model.goToPlanning
            )
            Spacer().frame(width: 24, height: 0, alignment: .center)
            
            TaskFieldButtonComponent(
                imageName: "notification",
                title: "notification",
                choosed: false,
                didTouch: model.goToNotification
            )
            Spacer().frame(width: 24, height: 0, alignment: .center)
            
            TaskFieldButtonComponent(
                imageName: "deadline",
                title: "Deadline",
                choosed: false,
                didTouch:model.goToDeadline
            )
            Spacer().frame(width: 24, height: 0, alignment: .center)
            
            TaskFieldButtonComponent(
                imageName: "repeat",
                title: "repeat",
                choosed: false,
                didTouch: model.goToRepeat
            )
        }
    }
}

extension AddTaskTextView{
    var submitButton: some View {
        Image("add_task_submit")
            .background(SolColor.colors().addTask.taskButtonsColor)
            .cornerRadius(12.0)
            .frame(width: 16, height: 16, alignment: .center)
    }
}

struct AddTaskTextView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskTextView(model: AddTaskViewModel())
    }
}
