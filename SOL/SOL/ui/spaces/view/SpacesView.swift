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
    @EnvironmentObject var slotStore: SlotStore
    
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [
                   .font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    var body: some View {
            ZStack {
                content                
                addSpaceSheet
                if model.goToLogout == true {
                    NavigationLink(
                        destination: LoginUIView(),
                        isActive: $model.goToLogout) {
                        EmptyView()
                    }
                }
            }
            .preferredColorScheme(.light)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)        
            .navigationTitle("Spaces")
            .onAppear(perform: {
                model.store = self.spaceStore
                addTaskModel.needShowTaskCreatedToast = true
                addTaskModel.changeView(
                    spaceId: nil,
                    taskId: nil,
                    taskDidCreated: model.taskDidCreated)
                
                spaceStore.taskStore = taskStore
                taskStore.spaceStore = spaceStore
                
                taskStore.slotStore = slotStore
                slotStore.taskStore = taskStore
                
                planningSlotsModel.taskStore = taskStore
                planningSlotsModel.spaceStore = spaceStore
                planningSlotsModel.slotStore = slotStore
                planningSlotsModel.type = .ALL
                
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



