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
                ForEach(spaceStore.spaces[model.spaceId]!.tasks, id: \.id) { task in
                    if taskStore.tasks[task.id] != nil {
                        TaskItemView(taskId: task.id)
                            .onDrag {
                                let item = NSItemProvider(object: NSString(string: task.id))
                                item.suggestedName = task.id
                                return item
                            }
                            .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
                                    perform: { (provider) -> Bool in
                                        guard let nsProvider = provider.first, let spaceIdSuggest = nsProvider.suggestedName
                                        else { return false}
                                        return false
//                                        return model.reorderTasks(draggetTaskId: spaceIdSuggest, dropOnTaskId: task.id)
                                    })
                    }
                }
                if (spaceStore.spaces[model.spaceId]!.tasks.count > 0){
                    Rectangle()
                        .foregroundColor(SolColor.colors().screen.background)
                        .frame(width: .infinity, height: 50, alignment: .center)
                        .onDrop(of: ["public.utf8-plain-text"], isTargeted: $isTarget,
                                perform: { (provider) -> Bool in
                                    guard let nsProvider = provider.first, let taskIdSuggest = nsProvider.suggestedName
                                    else { return false}
                                    return false
//                                    return taskStore.moveTaskToEnd(parentTaskId: <#T##String#>, draggetTaskId: <#T##String#>).moveTaskToEnd(draggetTaskId: taskIdSuggest)
                                })
                }
            }.id(taskStore.lastUpdateUUID)
            
            if (spaceStore.spaces[model.spaceId]!.tasks.count == 0 && model.state != .INITIALIZATION){
                VacuumView()
                    .frame(width: .infinity, height: 40, alignment: .center)
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


