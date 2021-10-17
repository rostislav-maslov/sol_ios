//
//  TaskItemContainerView.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.09.2021.
//

import SwiftUI

extension TaskItemView {
    var containerBackground: some View {
        HStack(alignment: VerticalAlignment.top){
            Spacer().frame(width: 8)
            VStack{
                defaultLine
            }
            Spacer().frame(width: 8)
        }
        .background(
            taskStore.tasks[taskId]?.status == TaskStatus.DONE ?
                SolColor.colors().taskLine.container :
                SolColor.colors().taskLine.container
        )
        .cornerRadius(12)
    }
}


//struct TaskItemContainerBackgroudView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskItemView(model:
//                        TaskItemViewModel(
//                            task: TaskEntity.forRender(),
//                            delegate: TaskItemViewModelProtocol.self as! TaskItemViewModelProtocol
//                        )
//        ).containerBackground
//    }
//}
