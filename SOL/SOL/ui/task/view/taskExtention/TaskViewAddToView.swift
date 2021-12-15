//
//  TaskHeader.swift
//  SOL
//
//  Created by Rostislav Maslov on 12.08.2021.
//

import Foundation
import SwiftUI

extension TaskView{
    var addToViewList: some View {
        VStack{
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Spacer().frame(width: 40, height: 1)
                    
                    Button("Add to view") {
                        
                    }
                    .padding(0)
                    .background(SolColor.colors().screen.background)
                    .foregroundColor(SolColor.colors().fontColors.second)
                    Spacer().frame(width: 8, height: 1)
                    
                    
                    ForEach(viewUserStore.root, id: \.id)  { viewUser in
                        AddTaskToViewButton(
                            title: viewUser.view!.icon!.data! + " " + viewUser.view!.title!,
                            isActive: viewUserStore.byTask[taskId] != nil && viewUserStore.byTask[taskId]!.contains(where: { taskInView in
                                return taskInView.viewId == viewUser.id
                            }) == true) {
                                viewUserStore.toggleTaskInView(taskId: taskId, viewId: viewUser.id)
                            }
                        Spacer().frame(width: 8, height: 1)
                    }
                    
                    
                    Spacer()
                }.background(SolColor.colors().screen.background)
            }
        }
    }
}

