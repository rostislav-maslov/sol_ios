//
//  TaskItemCheckboxView.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.09.2021.
//

import SwiftUI

extension TaskItemView {
    var checkbox: some View {
        VStack{
            if(taskStore.tasks[taskId]?.status == TaskStatus.OPEN){
                Spacer().frame(height: 12)
                HStack{
                    Spacer().frame(width: 6)
                    Image("ic_check_undone")
                        .resizable()
                        .renderingMode(.template)
                        .frame(
                            width: 18,
                            height: 18,
                            alignment: .center)
                        .foregroundColor(
                            SolColor.colors().checkBox.undoneBackground
                        )
                        .scaledToFill()
                    Spacer().frame(width: 4)
                }
                Spacer().frame(height: 12)
            }
            
            if(taskStore.tasks[taskId]?.status == TaskStatus.DONE){
                Spacer().frame(height: 17)
                HStack{
                    Spacer().frame(width: 9)
                    Image("ic_check_done")
                        .resizable()
                        .renderingMode(.template)
                        .frame(
                            width: 12,
                            height: 8,
                            alignment: .center)
                        .foregroundColor(
                            SolColor.colors().checkBox.doneBackground
                        )
                        .scaledToFill()
                    Spacer().frame(width: 7)
                }
                Spacer().frame(height: 12)
            }                                    
        }
    }
}

//struct TaskItemCheckboxView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskItemView(model: TaskItemViewModel(task: TaskEntity.forRenderDone(),
//                                              delegate: TaskItemViewModelProtocol.self as! TaskItemViewModelProtocol)).checkbox
//    }
//}
