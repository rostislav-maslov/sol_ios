//
//  TaskItemTitleView.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.09.2021.
//

import SwiftUI

extension TaskItemSubtaskView {
    var title: some View {
        VStack{
            Spacer().frame(height: 8)
            HStack{
                Spacer().frame(width: 4)
                Text(
                    taskStore.tasks[taskId]?.status == TaskStatus.OPEN ?
                        taskStore.tasks[taskId]!.fullTitle :
                        taskStore.tasks[taskId]!.title
                )
                .font(
                    SolFonts.font(
                        size: 16,
                        weight: Font.Weight.regular,
                        color: taskStore.tasks[taskId]?.status == TaskStatus.OPEN ?
                            SolColor.colors().fontColors.normal :
                            SolColor.colors().fontColors.second
                    ))
                .strikethrough(
                    taskStore.tasks[taskId]?.status == TaskStatus.DONE,
                    color: SolColor.colors().fontColors.second)
                .foregroundColor(
                    taskStore.tasks[taskId]?.status == TaskStatus.OPEN ?
                                    SolColor.colors().fontColors.normal :
                                    SolColor.colors().fontColors.second
                )
                Spacer().frame(
                    minWidth: 0,
                    idealWidth: 0,
                    maxWidth: 0,
                    minHeight: 25,
                    idealHeight: 25,
                    maxHeight: 25,
                    alignment: .center)
                Spacer()
            }.frame(width: .infinity)
            
            Spacer().frame(height: 0)
            
        }.background(SolColor.colors().taskLine.container)
    }
}
//
//struct TaskItemTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskItemView(model: TaskItemViewModel(task: TaskEntity.forRenderDone(), delegate: TaskItemViewModelProtocol.self as! TaskItemViewModelProtocol)).title
//    }
//}
