//
//  ViewWithTasksViewContent.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.12.2021.
//

import Foundation
import SwiftUI

extension ViewWithTasksView {
    var content: some View {
        ScrollViewReader { proxy in
            List {
                header
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
                //                picker
                //                    .listRowSeparator(Visibility.hidden)
                //                    .listRowInsets(EdgeInsets())
                //                    .listRowBackground(SolColor.colors().screen.background)
                
                if viewUserStore.byView[viewId] != nil {
                    
                    ForEach(viewUserStore.byView[viewId]!, id: \.taskId) { taskInView in
                        if taskStore.tasks[taskInView.taskId!] != nil {
                            TaskItemView(taskId: taskInView.taskId!, onTouchTask: {(taskGoToId: String) in
                                self.model.taskId = taskGoToId
                                self.model.spaceId = taskStore.tasks[taskInView.taskId!]!.spaceId!
                                self.model.goToTaskView = true
                            })
                                .id("SpaceViewList_\(taskInView.taskId!)")
                                .listRowSeparator(Visibility.hidden)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(SolColor.colors().screen.background)
                                .onDrop(of:  ["public.utf8-plain-text"], isTargeted: $model.isTarget, perform: { providers in
                                    print("sssss")
                                    return false
                                })
                        }
                    }
                    .onInsert(of: ["public.utf8-plain-text"], perform: { var1, var2 in
                        print("onInsert", var1, var2)
                    })
                                        
                }
                if (viewUserStore.byView[viewId] == nil){
                    VacuumView()
                        .listRowSeparator(Visibility.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(SolColor.colors().screen.background)
                        .frame(height: 40, alignment: .center)
                        .padding(EdgeInsets(top: 32.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
                }
                //                if(model.activeTab == 1){
                //                    Text("Details")
                //                        .listRowSeparator(Visibility.hidden)
                //                        .listRowInsets(EdgeInsets())
                //                        .listRowBackground(SolColor.colors().screen.background)
                //                }
                Spacer()
                    .id("ListLastItem")
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                    .frame(height: 142)
                
            }
            .alignmentGuide(VerticalAlignment.top, computeValue: { (vd:ViewDimensions) in
                return 0.0
            })
            .listStyle(PlainListStyle())
            .background(SolColor.colors().screen.background)
            .ignoresSafeArea(.all)
            .refreshable {
                
            }
            .onAppear {
                //model.scrollViewProxy = proxy
            }
        }
    }
}
