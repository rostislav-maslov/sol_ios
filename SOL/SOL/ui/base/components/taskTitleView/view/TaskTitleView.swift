//
//  TaskTitleView.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.09.2021.
//

import SwiftUI

struct TaskTitleView: View {
    var taskId: String
    @EnvironmentObject var taskStore: TaskStore
    @ObservedObject var model: TaskTitleModel
    @State var titleSize: CGFloat = 44
    init(taskId : String){
        self.taskId = taskId
        self.model = TaskTitleModel(taskId: taskId)
    }
    
    var body: some View {
        
            MultilineTextFieldView(text: taskStore.tasks[taskId]!.title, textColor: SolColor.colors().checkBox.undoneBackground, textSize: 24)
            { textDidChange in
                taskStore.tasks[taskId]?.title = textDidChange
            } textEditFinish: { textEditFinish in
                taskStore.tasks[taskId]?.title = textEditFinish
                taskStore.saveTitleIcon(taskId: taskId, title: textEditFinish, iconData: taskStore.tasks[taskId]!.icon.data)
            } titleSizeDidChange: { titleSize in
                self.titleSize = titleSize
            } multilineTextFieldView: { textView in
                
            }
            .font(SolFonts.font(
                    size: 24,
                    weight: Font.Weight.medium,
                    color: SolColor
                        .colors()
                        .checkBox
                        .undoneBackground))
            .frame(
                width: .infinity,
                height: titleSize,
                alignment: .center)
            .foregroundColor(
                SolColor
                    .colors()
                    .checkBox
                    .doneBackground)
            .onAppear(perform: {
                self.model.taskStore = self.taskStore
            })
        
        
    }
}



//struct TaskTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskTitleView()
//    }
//}

