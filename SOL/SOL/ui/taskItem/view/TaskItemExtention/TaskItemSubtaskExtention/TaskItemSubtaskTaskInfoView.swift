//
//  TaskItemSubtaskTaskInfoView.swift
//  SOL
//
//  Created by Rostislav Maslov on 28.09.2021.
//

import Foundation
import SwiftUI

extension TaskItemSubtaskView {
    var taskInfo: some View {
        HStack{
            Spacer().frame(width: 4)
            Text(taskStore.tasks[taskId]!.taskInfo)
                .font(SolFonts.font(size: 14, weight: Font.Weight.regular, color: SolColor.colors().fontColors.second))
                .foregroundColor(SolColor.colors().fontColors.second)
            Spacer()
        }.background(SolColor.colors().taskLine.container)
        
    }
}
//
//struct TaskItemTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskItemView(model: TaskItemViewModel(task: TaskEntity.forRenderDone(), delegate: TaskItemViewModelProtocol.self as! TaskItemViewModelProtocol)).title
//    }
//}
