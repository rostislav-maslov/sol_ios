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
        .id("TaskItemView"+taskStore.lastUpdateUUID.uuidString)
        .onAppear(perform: {
            self.model.taskStore = taskStore
            if taskStore.tasks[taskId]?.title == "" {
                taskStore.syncTask(taskId: taskId)
            }
        })
    }
}

extension TaskItemView{
    var defaultLine: some View {
        VStack{
            HStack(alignment: .top, spacing: 0, content: {
                Button(action: {
                    self.model.onTouchCheckbox()
                    taskStore.changeStatus(taskId: self.taskId)
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }, label: {
                    checkbox
                })                              
                PushView(
                    destination: TaskView(taskId: self.taskId),
                    label: {
                       title
                    })
                    .buttonStyle(PlainButtonStyle())
                VStack{
                    if self.taskStore.tasks[taskId]?.hasChild == true {
                        Button(action: {
                            print("ic_task_item_expand")
                        }, label: {
                            VStack{
                                Spacer().frame(height: 19)
                                HStack{
                                    Spacer().frame(width: 8)
                                    Image("ic_task_item_expand")
                                        .frame(
                                            width: 12,
                                            height: 6,
                                            alignment: .center)
                                    Spacer().frame(width: 8)
                                }
                                Spacer().frame(height: 14)
                            }
                        })
                    }
                }
            })
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
