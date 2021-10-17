//
//  SpaceViewContent.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI


extension SpaceView {
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
                picker
                    .listRowSeparator(Visibility.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(SolColor.colors().screen.background)
                if(model.activeTab == 0){
                    ForEach(spaceStore.spaces[spaceId]!.tasks, id: \.id) { task in
                        if taskStore.tasks[task.id] != nil {
                            TaskItemView(taskId: task.id, onTouchTask: {(taskId: String) in
                                self.taskId = taskId
                                self.goToTaskView = true
                            })
                                .id("SpaceViewList_\(task.id)")
                                .listRowSeparator(Visibility.hidden)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(SolColor.colors().screen.background)
                        }
                    }
                    
                    if (spaceStore.spaces[spaceId]!.tasks.count == 0 && model.state != .INITIALIZATION){
                        VacuumView()
                            .listRowSeparator(Visibility.hidden)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(SolColor.colors().screen.background)
                            .frame(height: 40, alignment: .center)
                            .padding(EdgeInsets(top: 32.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
                    }
                }
                if(model.activeTab == 1){
                    Text("Details")
                        .listRowSeparator(Visibility.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(SolColor.colors().screen.background)
                }
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
                print("pull")
            }
            .onAppear {
                model.scrollViewProxy = proxy
            }
        }
    }
}
