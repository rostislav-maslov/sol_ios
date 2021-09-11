//
//  TaskHeader.swift
//  SOL
//
//  Created by Rostislav Maslov on 12.08.2021.
//

import Foundation
import SwiftUI

extension TaskView{
    var header: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            headerSpacer
            taskTitle
            Spacer().frame(width: 1, height: .infinity, alignment: .center)
        })
    }
}

extension TaskView{
    var taskTitle: some View {
        
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 13, height: 11, alignment: .center)
            VStack{
                Spacer().frame(width: 0, height: 9, alignment: .center)
                CheckBoxView(size: .NORMAL, done: $model.actionDone) {
                    model.toggleTask()
                }
            }
            
            VStack(alignment: .leading, spacing: 0, content: {
                TaskTitleView(taskId: taskId)
            })
            
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}

extension TaskView {
    var actionsTitle:some View {
        VStack{
            //Spacer().frame(width: 1, height: 16, alignment: .center)
            
            HStack(alignment: .center){
                Spacer()
                    .frame(width: 12, height: 0, alignment: .center)
                IconComponent(size: 24, icon: "⚙️")
                Spacer()
                    .frame(width: 8, height: 0, alignment: .center)
                Text("Actions")
                    .font(
                        SolFonts.font(
                            size: 24,
                            weight: Font.Weight.medium,
                            color: SolColor.colors().fontColors.normal))
                Spacer()
                Spacer().frame(width: 16, height: 0, alignment: .center)
            }
        }
    }
}


extension TaskView {
    var headerSpacer: some View {
        HStack{
            Spacer()
                .frame(
                    width: .infinity,
                    height: (41 + 41 + CGFloat(NavigationBarHelper.heightDelta)),
                    alignment: .center)
        }
    }
}

//struct TaskHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(model: TaskViewModel(task: TaskEntity.forRender()))
//    }
//}
