//
//  ZContainer.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.05.2021.
//

import SwiftUI


struct SpacesView: View {
    public static let VIEW_ID = "SpacesView"
    
    @StateObject var model = SpacesViewModel()
    
    @State var editMode: EditMode = .active
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [
                   .font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    var body: some View {
            ZStack {
                content                                
                
                PlanningSlotsView(
                    delegate: self.model,                    
                    isPresented: $model.showPlanning,
                    type: PlanningType.VIEW)
                    .colorScheme(ColorScheme.light)
                
                NavigationLink(
                    destination: LoginUIView(),
                    isActive: $model.goToLogout) {
                    EmptyView()
                }
            }
            .preferredColorScheme(.light)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)        
            .navigationTitle("Spaces")
            .onAppear(perform: {
                model.store = self.spaceStore
                addTaskModel.needShowTaskCreatedToast = true
                addTaskModel.changeView(spaceId: nil, taskId: nil, taskDidCreated: model.taskDidCreated)
                spaceStore.taskStore = taskStore
                taskStore.spaceStore = spaceStore
                spaceStore.sync()
            })
            .onDisappear {
                addTaskModel.needShowTaskCreatedToast = false
            }
    }
}

struct SpacesView_Previews: PreviewProvider {
    static var previews: some View {
        SpacesView()
    }
}



