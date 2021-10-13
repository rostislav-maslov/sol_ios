//
//  ZContainer.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.05.2021.
//

import SwiftUI
import AlertToast

struct SpacesView: View {
    public static let VIEW_ID = "SpacesView"
    
    @ObservedObject var model = SpacesViewModel()
 
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var taskStore: TaskStore
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [
                   .font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    var body: some View {
            ZStack {
                NavigationLink(
                    destination: LoginUIView(),
                    isActive: $model.goToLogout) {
                    EmptyView()
                }
                content
                
                AddTaskRootView(spaceId: nil, parentTaskId: nil) {
                    model.showToastSuccessCreate = true
                }
                
                PlanningSlotsView(
                    delegate: self.model,                    
                    isPresented: $model.showPlanning,
                    type: PlanningType.VIEW)
                    .colorScheme(ColorScheme.light)
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
            .toast(isPresenting: $model.showToastSuccessCreate){
                AlertToast(
                    displayMode: .hud,
                    type: .regular,
                    title: "Task did create 👍",
                    subTitle: "Take a look on inbox space"
                )                
            }
        
        
    }
}

struct SpacesView_Previews: PreviewProvider {
    static var previews: some View {
        SpacesView()
    }
}



