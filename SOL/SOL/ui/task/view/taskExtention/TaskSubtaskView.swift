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
                        .onDrag {
                            let item = NSItemProvider(object: NSString(string: task.id))
                            item.suggestedName = task.id
                            return item
                        }
                        .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
                                perform: { (provider) -> Bool in
                                    guard let nsProvider = provider.first, let spaceIdSuggest = nsProvider.suggestedName
                                        else { return false}
                                    return model.reorderTasks(draggetTaskId: spaceIdSuggest, dropOnTaskId: task.id)
                        })
                }
                if (model.task.child.count > 0){
                    Rectangle()
                        .foregroundColor(SolColor.colors().screen.background)
                        .frame(width: .infinity, height: 50, alignment: .center)
                        .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
                                perform: { (provider) -> Bool in
                                    guard let nsProvider = provider.first, let taskIdSuggest = nsProvider.suggestedName
                                        else { return false}
                                    return model.moveTaskToEnd(draggetTaskId: taskIdSuggest)
                        })
                }
                if (model.task.child.count == 0){
                    Text("Vacuum")
                }
                Spacer().frame(width: 1, height: 16, alignment: .center)
            }
        }
    }
}
