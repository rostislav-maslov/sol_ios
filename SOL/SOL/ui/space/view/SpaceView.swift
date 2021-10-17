//
//  SpaceView.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI




public struct SpaceView: View {
    var spaceId: String
    
    @StateObject var model: SpaceViewModel = SpaceViewModel()
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    
    @State public var isEditable = true
    @State var isTarget = true
    @State var goToTaskView = false
    @State var taskId: String = ""
    @State var placeholder = "🪐"
    
    
    @Environment(\.presentationMode) var presentationMode
    
    var emojiTextField: EmojiTextField?    
    
    init(spaceId: String){
        self.spaceId = spaceId
        
        UINavigationBar.appearance().titleTextAttributes = [
                   .font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
                
    }
    
    public var body: some View {        
        ZStack {
            content            
            PlanningSlotsView(
                delegate: self.model,
                isPresented: $model.showPlanning,
                type: PlanningType.VIEW)
                .colorScheme(ColorScheme.light)
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {
                    spaceStore.spaces[spaceId]!.icon.data = model.emoji
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                    addTaskModel.state = .PLACEHOLDER
                    self.model.stopEditIcon = true
                    spaceStore.saveTitleIcon(
                        spaceId: spaceId,
                        title: spaceStore.spaces[spaceId]!.title,
                        data: spaceStore.spaces[spaceId]!.icon.data)
                })
            }
            
            NavigationLink(
                destination: TaskView(spaceId: self.spaceId, taskId: self.taskId),
                isActive: $goToTaskView,
                label:{
                    
                })
                .frame(width: 0, height: 0)
                .buttonStyle(PlainButtonStyle())
                
        }
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.light)
        .navigationTitle(spaceStore.spaces[spaceId]?.title ?? "")
        .navigationBarHidden(false)
        .onAppear(perform: {
            self.model.spaceId = spaceId
            self.model.emoji = spaceStore.spaces[spaceId]!.icon.data
            self.addTaskModel.changeView(spaceId: spaceId, taskId: nil, taskDidCreated: model.taskDidCreated)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.spaceStore.sync(spaceId: self.spaceId)
            }
        })
    }
}



