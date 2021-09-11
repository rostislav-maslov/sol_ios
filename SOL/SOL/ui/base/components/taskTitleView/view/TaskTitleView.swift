//
//  TaskTitleView.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.09.2021.
//

import SwiftUI

struct TaskTitleView: View {
    var taskId: String
    @ObservedObject var multilineTextFieldModel:MultilineTextFieldModel = MultilineTextFieldModel()
    @EnvironmentObject var taskStore: TaskStore
    @ObservedObject var model: TaskTitleModel
    
    init(taskId : String){
        self.taskId = taskId
        self.model = TaskTitleModel(taskId: taskId)
        self.multilineTextFieldModel.delegate = self.model
    }
    
    var body: some View {
        MultilineTextFieldView(
            text: taskStore.tasks[taskId]!.title,
            model: self.multilineTextFieldModel,
            textColor: UIColor(
                SolColor
                    .colors()
                    .checkBox
                    .undoneBackground),
            textSize: 24)
            .font(SolFonts.font(
                    size: 24,
                    weight: Font.Weight.medium,
                    color: SolColor
                        .colors()
                        .checkBox
                        .undoneBackground))
            .frame(
                width: .infinity,
                height: multilineTextFieldModel.titleSize,
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

