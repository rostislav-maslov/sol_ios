//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.07.2021.
//

import SwiftUI
import NavigationStack

struct TaskItemView: View {
    @ObservedObject  var model: TaskItemViewModel
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    
    var taskId: String
    
    init(taskId: String){
        self.taskId = taskId
        self.model = TaskItemViewModel(taskId: taskId)
    }
    
    var body: some View {
        VStack{
            Spacer()
                .frame(width: 1, height: 8, alignment: .center)
            HStack{
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
                containerBackground
                Spacer()
                    .frame(width: 16, height: 0, alignment: .center)
            }
            Spacer()
                .frame(width: 1, height: 8, alignment: .center)
        }
        
        .onAppear(perform: {
            self.model.taskStore = taskStore
            if taskStore.tasks[taskId]?.loadStatus == .INITIAL {
                taskStore.syncTask(taskId: taskId)
            }
        })
    }
}

extension TaskItemView{
    var defaultLine: some View {
        Group{
            TaskItemSubtaskView(taskId: taskId, isChild: false)
           
        }
        
    }
}

//struct TaskItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskItemView(
//            model:
//                TaskItemViewModel(
//                    task: TaskEntity.forRenderDone())
//        )
//    }
//}
