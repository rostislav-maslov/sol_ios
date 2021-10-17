//
//  SpaceViewSubtask.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI


extension SpaceView {
    
    
    var subtasks: some View {
        HStack{
            VStack {
                Spacer().frame(width: 1, height: 16, alignment: .center)
                ForEach(spaceStore.spaces[model.spaceId!]!.tasks, id: \.id) { task in
                    if taskStore.tasks[task.id] != nil {
//                        TaskItemView(taskId: task.id)
//                            .onDrag {
//                                let item = NSItemProvider(object: NSString(string: task.id))
//                                item.suggestedName = task.id
//                                return item
//                            }
//                            .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
//                                    perform: { (provider) -> Bool in
//                                        guard let nsProvider = provider.first, let taskIdSuggest = nsProvider.suggestedName
//                                        else { return false}
//                                        return taskStore.reorderTasks(parentTaskId: spaceId, draggetTaskId: taskIdSuggest, dropOnTaskId: task.id)
//                                    })
                    }
                }
                if (spaceStore.spaces[model.spaceId!]!.tasks.count > 0){
                    Rectangle()
                        .foregroundColor(SolColor.colors().screen.background)
                        .frame(height: 50, alignment: .center)
                        .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
                                perform: { (provider) -> Bool in
                                    guard let nsProvider = provider.first, let taskIdSuggest = nsProvider.suggestedName
                                    else { return false}
                                    return taskStore.moveTaskToEnd(parentTaskId: spaceId, draggetTaskId: taskIdSuggest)
                                })
                }
            }.id("SpaceView_subtasks_" + spaceStore.spaces[spaceId]!.lastUpdateUUID.uuidString)
            
            if (spaceStore.spaces[model.spaceId!]!.tasks.count == 0 && model.state != .INITIALIZATION){
                VacuumView()
                    .frame(height: 40, alignment: .center)
                    .padding(EdgeInsets(top: 32.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
            }
            Spacer().frame(width: 1, height: 16, alignment: .center)
        }
    }
}


//
//struct SpaceView_Subtask_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        SpaceView(model: SpaceViewModel("1111"))
//    }
//}


