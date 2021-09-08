//
//  TaskItemTitleView.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.09.2021.
//

import SwiftUI

extension TaskItemView {
    var title: some View {
        VStack{
            Spacer().frame(height: 8)
            HStack{
                Spacer().frame(width: 4)
                Text(
                    model.task.status == TaskStatus.OPEN ?
                        model.task.fullTitle() :
                        model.task.title
                )
                .font(
                    SolFonts.font(
                        size: 16,
                        weight: Font.Weight.regular,
                        color: model.task.status == TaskStatus.OPEN ?
                            SolColor.colors().fontColors.normal :
                            SolColor.colors().fontColors.second
                    ))
                .strikethrough(
                    model.task.status == TaskStatus.DONE,
                    color: SolColor.colors().fontColors.second)
                .foregroundColor(
                    model.task.status == TaskStatus.OPEN ?
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
            Spacer().frame(height: 8)
        }.background(SolColor.colors().taskLine.container)
    }
}

struct TaskItemTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(model: TaskItemViewModel(task: TaskEntity.forRenderDone(), delegate: TaskItemViewModelProtocol.self as! TaskItemViewModelProtocol)).title
    }
}
