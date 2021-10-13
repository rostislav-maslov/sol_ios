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
                if taskStore.tasks[self.taskId] != nil {
                    ForEach(taskStore.tasks[self.taskId]!.child, id: \.id) { task in
                        TaskItemView(taskId: task.id)
                            .onDrag {
                                let item = NSItemProvider(object: NSString(string: task.id))
                                item.suggestedName = task.id
                                return item
                            }
                            .onDrop(of: ["public.utf8-plain-text"], isTargeted: $model.isTarget,
                                    perform: { (provider) -> Bool in
                                guard let nsProvider = provider.first, let taskIdSuggest = nsProvider.suggestedName
                                else { return false}
                                return taskStore.reorderTasks(parentTaskId: taskId, draggetTaskId: taskIdSuggest, dropOnTaskId: task.id)
                            })
                    }
                    
                    if (taskStore.tasks[self.taskId]!.child.count > 0){
                        Rectangle()
                            .foregroundColor(SolColor.colors().screen.background)
                            .frame(width: .infinity, height: 50, alignment: .center)
                            .onDrop(of: ["public.utf8-plain-text"], isTargeted: $model.isTarget,
                                    perform: { (provider) -> Bool in
                                guard let nsProvider = provider.first, let taskIdSuggest = nsProvider.suggestedName
                                else { return false}
                                return taskStore.moveTaskToEnd(parentTaskId: taskId, draggetTaskId: taskIdSuggest)
                            })
                    }
                    if (taskStore.tasks[self.taskId]!.child.count == 0 && self.model.state != .INITIALIZATION){
                        VacuumView()
                        
                            .padding(EdgeInsets(top: 32.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
                    }
                }
                Spacer().frame(width: 1, height: 16, alignment: .center)
            }
        }
    }
}

//struct TaskView_Subtask_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(model: TaskViewModel(task: TaskEntity.forRender()))
//    }
//}

