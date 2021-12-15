//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import SwiftUI


extension TaskView {
    
    var content: some View {
        ScrollViewReader { proxy in
            List {
                header
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                addToViewList
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                
                actionsTitle
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                actionsButton
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                picker
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                if(model.activeTab == 0){
                    if taskStore.tasks[self.taskId] != nil {
                        ForEach(taskStore.tasks[self.taskId]!.child, id: \.id) { task in
                            TaskItemView(taskId: task.id, onTouchTask: {(taskId:String) in
                                goToTaskId = taskId
                                goToTaskView = true
                            })
                                .listRowSeparator(Visibility.hidden)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(SolColor.colors().screen.background)
                                .onDrag {
                                    let item = NSItemProvider(object: NSString(string: task.id))
                                    item.suggestedName = taskId
                                    return item
                                }
                        }
                        .onInsert(of: ["public.utf8-plain-text"], perform: { var1, var2 in
                            print("onInsert", var1, var2)
                        })
                        
                        if (taskStore.tasks[self.taskId]!.child.count == 0){
                            VacuumView()
                                .listRowSeparator(Visibility.hidden)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(SolColor.colors().screen.background)
                                .padding(EdgeInsets(top: 32.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
                        }
                    }
                }
                if(model.activeTab == 1){
                    Text("Details")
                        .listRowSeparator(Visibility.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(SolColor.colors().screen.background)
                }
                if(model.activeTab == 2){
                    Text("files")
                        .listRowSeparator(Visibility.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(SolColor.colors().screen.background)
                }
                if(model.activeTab == 3){
                    Text("photo")
                        .listRowSeparator(Visibility.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(SolColor.colors().screen.background)
                }
                Spacer()
                    .id("ListLastItem")
                    .frame(height: 142)
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                
            }
            .alignmentGuide(VerticalAlignment.top, computeValue: { (vd:ViewDimensions) in
                return 0.0
            })
            .listStyle(PlainListStyle())
            .background(SolColor.colors().screen.background)
            .refreshable {
                self.taskStore.syncTask(taskId: taskId)
            }
            .onAppear {
                self.model.scrollViewProxy = proxy
            }
        }
        .background(SolColor.colors().screen.background)
        .ignoresSafeArea(.all)
    }
}







