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
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    
    @State var forNotifyCombine: String = ""
    @State var showToast = false
    @State var placeholder = ""
    @State var stopEditing = false
    
    init(model:AddTaskViewModel) {
        self.model = model        
        print("AddTaskTextView - \(model.task.title)")
    }
    
    var body: some View {
        ZStack{
            backgroundView
            
            VStack{                
                titleField
                if model.task.hasTaskInfo == true {
                    taskInfo
                }
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
                .frame(width: nil, height: 30, alignment: .center)
                //Spacer().frame(width: 0.0, height: 8.0, alignment: .center)
                //deadlineFastLine
                
                Spacer().frame(width: 0.0, height: 8.0, alignment: .center)
            }
        }        
        .frame(width: nil)    
        .onAppear(perform: {
            print("AddTaskTextView - did appear")
            model.taskStore = taskStore
            model.spaceStore = spaceStore
        })
    }
}

extension AddTaskTextView{
    var backgroundView: some View {
        Rectangle()
            .fill(SolColor.colors().addTask.addTaskBackground)
            .cornerRadius(12, corners: [.topLeft, .topRight])
            .frame(
                width: nil,
                height: 64 + self.model.titleTextSize + self.model.taskInfoSize,                
                alignment: .center)
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
            Spacer().frame(width: 8)
            MultilineTextFieldView(
                text: model.task.title,
                textColor: SolColor.colors().checkBox.undoneBackground,
                textSize: 16)
            { textDidChange in
                model.task.title = textDidChange
                forNotifyCombine = textDidChange
            } textEditFinish: { textEditFinish in
                
                model.task.title = textEditFinish
                model.submit(false)
                
                forNotifyCombine = textEditFinish
            } titleSizeDidChange: { titleSize in
                if titleSize != self.model.titleTextSize {
                    self.model.titleTextSize = titleSize
                }
            } multilineTextFieldView: { textView in
                self.model.titleTextView = textView
                textView.becomeFirstResponder()
            }
            .font(SolFonts.font(
                    size: 24,
                    weight: Font.Weight.medium,
                    color: SolColor.colors().checkBox.undoneBackground))
            .frame(
                height: self.model.titleTextSize
            )
            .foregroundColor(SolColor.colors().checkBox.doneBackground)
            Spacer().frame(width: 8)
        }.frame(width: UIScreen.main.bounds.width)
    }
}

// MARK: Task Info
extension AddTaskTextView {
    var taskInfo: some View {
        HStack{
            Spacer().frame(width: 14, height: 0, alignment: .center)
            Text(model.task.taskInfo)
                .font(SolFonts.font(size: 11, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                .foregroundColor(SolColor.colors().fontColors.second)
            Spacer()
        }.frame(width: nil)
    }
}

extension AddTaskTextView{    
    var iconChose: some View {
        IconFieldComponent(placeholder: $placeholder, emoji: $model.task.icon.data, stopEditing: $stopEditing) {
        }
    }
}


extension AddTaskTextView{
    
    var submitButton: some View {
        Button(action: {            
            model.submit(true)
        }, label: {
            Image("add_task_submit")
                .background(model.task.title.count > 0 ? SolColor.colors().addTask.taskButtonActiveColor : SolColor.colors().addTask.taskButtonDefaultColor)
                .cornerRadius(12.0)
                .frame(width: 16, height: 16, alignment: .center)
        })
        .id("AddTasdskTextView_submitButton_\(forNotifyCombine)")
        .disabled(model.task.title.count == 0)
    }
}

//struct AddTaskTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskTextView(model: AddTaskViewModel(nil, parentTaskId: nil))
//    }
//}
