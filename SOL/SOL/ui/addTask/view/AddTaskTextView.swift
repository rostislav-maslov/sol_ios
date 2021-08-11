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
    @State var fieldFocus = true
    
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
            AddTaskTextFieldView(
                text: $model.task.title,
                textFieldShouldBeginEditing: {
                },
                placeholder: "Type your task") { (textField: UITextField) in
                textField.becomeFirstResponder()
            }
            .frame(width: .infinity, height: 16, alignment: .center)
            .padding()
            
            
            
//            TextField("Type your task", text: $model.task.title)
//                .font(
//                    SolFonts.font(
//                        size: 16,
//                        weight: Font.Weight.medium,
//                        color: SolColor.colors().fontColors.normal))
//                .padding()
            
        }
    }
}

extension AddTaskTextView{
    var iconChose: some View {
        IconFieldComponent(placeholder: "", value: $model.task.icon.data, state: $stateIcon, textFieldShouldBeginEditing: {
            
        }, callbackEmojiTextField: { (emojiTextField:UIEmojiTextField) in
            
        })
    }
}

extension AddTaskTextView{
    var buttonsLine: some View {
        HStack {
            TaskFieldButtonComponent(
                imageName: "ic_calendar",
                title: "planning",
                choosed: model.buttonState.hasSlots,
                didTouch: model.goToPlanning
            )
            Spacer().frame(width: 24, height: 0, alignment: .center)
            
            TaskFieldButtonComponent(
                imageName: "notification",
                title: "notification",
                choosed: model.buttonState.hasNotification,
                didTouch: model.goToNotification
            )
            Spacer().frame(width: 24, height: 0, alignment: .center)
            
            TaskFieldButtonComponent(
                imageName: "deadline",
                title: "Deadline",
                choosed: model.buttonState.hasDeadline,
                didTouch:model.goToDeadline
            )
            Spacer().frame(width: 24, height: 0, alignment: .center)
            
            TaskFieldButtonComponent(
                imageName: "repeat",
                title: "repeat",
                choosed: model.buttonState.hasRepeat,
                didTouch: model.goToRepeat
            )
        }
    }
}

extension AddTaskTextView{
    
    var submitButton: some View {
        Button(action: {
            model.submit()
        }, label: {
            Image("add_task_submit")
                .background(model.task.title.count > 0 ? SolColor.colors().addTask.taskButtonActiveColor : SolColor.colors().addTask.taskButtonDefaultColor)
                .cornerRadius(12.0)
                .frame(width: 16, height: 16, alignment: .center)
        }).disabled(model.task.title.count == 0)
    }
}

struct AddTaskTextView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskTextView(model: AddTaskViewModel(nil, parentTaskId: nil))
    }
}
