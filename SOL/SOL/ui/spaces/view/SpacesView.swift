//
//  ZContainer.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.05.2021.
//

import SwiftUI
import NavigationStack

struct SpacesView: View {
    @ObservedObject var model = SpacesViewModel()
    @ObservedObject var addTaskViewModel = AddTaskViewModel(nil, parentTaskId: nil)
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var tastStore: TaskStore
    
    var body: some View {
        NavigationStackView{
            ZStack {
                NavigationLink(
                    destination: LoginUIView(),
                    isActive: $model.goToLogout) {
                    EmptyView()
                }
                content
                AddTaskRootView(
                    model: addTaskViewModel,
                    parentTitle: $model.defaultTaskAddTitle)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .preferredColorScheme(.light)
            .onAppear(perform: {
                model.store = self.spaceStore
                spaceStore.sync()
            })
        }
    }
}

struct SpacesView_Previews: PreviewProvider {
    static var previews: some View {
        SpacesView()
    }
}



