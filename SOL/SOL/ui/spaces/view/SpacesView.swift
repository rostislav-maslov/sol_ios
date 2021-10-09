//
//  ZContainer.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.05.2021.
//

import SwiftUI

struct SpacesView: View {
    public static let VIEW_ID = "SpacesView"
    
    @ObservedObject var model = SpacesViewModel()
 
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var taskStore: TaskStore
    
    var body: some View {
            ZStack {
                NavigationLink(
                    destination: LoginUIView(),
                    isActive: $model.goToLogout) {
                    EmptyView()
                }
                content
                AddTaskRootView(spaceId: nil, parentTaskId: nil) {
                }
            }
            .preferredColorScheme(.light)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationTitle("Spaces")
            .onAppear(perform: {
                model.store = self.spaceStore
                spaceStore.taskStore = taskStore
                taskStore.spaceStore = spaceStore
                spaceStore.sync()
            })
        
    }
}

struct SpacesView_Previews: PreviewProvider {
    static var previews: some View {
        SpacesView()
    }
}



