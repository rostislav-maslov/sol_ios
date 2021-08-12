//
//  TaskSubtaskView.swift
//  SOL
//
//  Created by Rostislav Maslov on 12.08.2021.
//

import Foundation
import SwiftUI

extension TaskView{
    var subtasks: some View {
        HStack{
            VStack {
                Spacer().frame(width: 1, height: 16, alignment: .center)
                ForEach(model.task.child, id: \.id) { task in
                    TaskItemView(model: TaskItemViewModel(task: task))
                }
                if (model.task.child.count == 0){
                    Text("Vacuum")
                }
                Spacer().frame(width: 1, height: 16, alignment: .center)
            }
        }
    }
}
