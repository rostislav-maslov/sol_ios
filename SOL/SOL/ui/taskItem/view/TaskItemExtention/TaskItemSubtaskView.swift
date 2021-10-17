//
//  TaskItemSubtaskView.swift
//  SOL
//
//  Created by Rostislav Maslov on 15.09.2021.
//

import SwiftUI

struct TaskItemSubtaskView: View {
    
    var taskId: String
    var isChild: Bool
    var onTouchTask: ((_ taskId: String) -> Void)
    @State var lasUpdate = UUID()
    @EnvironmentObject var taskStore: TaskStore
    
    var body: some View {
        Group{
            HStack(alignment: .top, spacing: 0, content: {
                Button(action: {
                    taskStore.changeStatus(taskId: self.taskId)
                    UINotificationFeedbackGenerator.generate(.TASK_DONE)
                }, label: {
                    checkbox
                }).buttonStyle(PlainButtonStyle())
                
                Button (action: {
                    self.onTouchTask(taskId)
                }, label: {
                    VStack{
                        title
                        if taskStore.tasks[taskId]!.hasTaskInfo {
                            taskInfo
                        }
                        Spacer().frame(height: 8)
                    }
                }).buttonStyle(PlainButtonStyle())

                    
                VStack{
                    if self.taskStore.tasks[taskId]!.child.count > 0 && isChild == false {
                        Button(action: {
                            withAnimation {
                                taskStore.tasks[taskId]!.showSubtask = !taskStore.tasks[taskId]!.showSubtask
                                self.lasUpdate = UUID()
                            }
                        }, label: {
                            VStack{
                                Spacer().frame(height: 19)
                                HStack{
                                    Spacer().frame(width: 8)
                                    if self.taskStore.tasks[self.taskId]?.showSubtask == false {
                                        Image("ic_task_item_expand")
                                            .frame(
                                                width: 12,
                                                height: 6,
                                                alignment: .center)
                                    }else{
                                        Image("ic_task_item_expand_close")
                                            .frame(
                                                width: 12,
                                                height: 6,
                                                alignment: .center)
                                    }
                                    Spacer().frame(width: 8)
                                }
                                Spacer().frame(height: 14)
                            }
                        }).buttonStyle(PlainButtonStyle())
                    }
                }
            })
            Group{
                if taskStore.tasks[taskId]?.showSubtask == true {
                    Rectangle()
                        .foregroundColor(SolColor.colors().taskLine.divider)
                        .frame(width: .infinity, height: 1, alignment: Alignment.center)
                    VStack {
                        ForEach(taskStore.tasks[self.taskId]!.child, id: \.id) { task in
                            TaskItemSubtaskView(taskId: task.id, isChild: true, onTouchTask: self.onTouchTask)
                        }
                    }
                }
            }.id("TaskItemSubtaskView_Subs_\(lasUpdate.uuidString)")
            
        }
        
    }
}
//
//struct TaskItemSubtaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskItemSubtaskView(taskId: "")
//    }
//}
