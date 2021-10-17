//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 20.07.2021.
//

import SwiftUI

struct TaskItemView: View {
    @StateObject  var model: TaskItemViewModel = TaskItemViewModel()
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    
    var taskId: String
    var onTouchTask: ((_ taskId: String) -> Void)
    
    init(taskId: String, onTouchTask: @escaping ((_ taskId: String) -> Void)){
        self.taskId = taskId
        self.onTouchTask = onTouchTask
    }
    
    var body: some View {
        VStack{
            Spacer()
                .frame(width: 1, height: 8, alignment: .center)
            HStack(alignment: VerticalAlignment.top){
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
            self.model.taskId = self.taskId
            self.model.taskStore = taskStore
            if taskStore.tasks[taskId]?.loadStatus == .INITIAL {
                taskStore.syncTask(taskId: taskId)
            }
        })
    }
}

extension TaskItemView{
    var defaultLine: some View {
            TaskItemSubtaskView(taskId: taskId, isChild: false, onTouchTask: self.onTouchTask)
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
