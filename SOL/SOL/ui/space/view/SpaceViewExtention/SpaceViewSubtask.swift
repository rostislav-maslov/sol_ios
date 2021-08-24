//
//  SpaceViewSubtask.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpaceView {
    var subtasks: some View {
        HStack{
            VStack {
                Spacer().frame(width: 1, height: 16, alignment: .center)
                ForEach(model.space.tasks, id: \.id) { task in
                    TaskItemView(model: TaskItemViewModel(task: task))
                }
                if (model.space.tasks.count == 0){
                    Text("Vacuum")
                }
                Spacer().frame(width: 1, height: 16, alignment: .center)
            }
        }
    }
}
