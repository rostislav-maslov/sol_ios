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
    
    @State var defaultTaskAddTitle = "in Inbox"
    @State var isTarget = true
    
    var body: some View {
        NavigationStackView{
            ZStack {
                NavigationLink(destination: LoginUIView(), isActive: $model.goToLogout) {EmptyView()}
                content
                AddTaskRootView(model: addTaskViewModel, parentTitle: $defaultTaskAddTitle)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .preferredColorScheme(.light)
            .onAppear(perform: {
                model.load()
            })
        }
    }
}

struct SpacesView_Previews: PreviewProvider {
    static var previews: some View {
        SpacesView()
        
    }
}



