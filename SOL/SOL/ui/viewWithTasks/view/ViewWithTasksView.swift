//
//  ViewWithTasksView.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.12.2021.
//

import Foundation
import SwiftUI

public struct ViewWithTasksView: View {
    var viewId: String
    
    @StateObject var model: ViewWithTasksModel = ViewWithTasksModel()
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    @EnvironmentObject var addTaskModel: AddTaskViewModel
    @EnvironmentObject var planningSlotsModel: PlanningSlotsModel
    @EnvironmentObject var viewUserStore: ViewUserStore
    @State var isPresented = false
    @State var showSuggestSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    //    @State public var isEditable = true
    //    @State var isTarget = true
    //    @State var goToTaskView = false
    //    @State var taskId: String = ""
    //    @State var placeholder = "🪐"
    
    var emojiTextField: EmojiTextField?
    
    init(viewId: String){
        self.viewId = viewId
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    public var body: some View {
        ZStack {
            content
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {
                    viewUserStore.all[self.viewId]!.view!.icon!.data = model.emoji
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                    addTaskModel.state = .PLACEHOLDER
                    self.model.stopEditIcon = true
                    //                    spaceStore.saveTitleIcon(
                    //                        spaceId: spaceId,
                    //                        title: viewUserStore.all[self.viewId]!.view!.title,
                    //                        data: viewUserStore.all[self.viewId]!.view!.icon.data)
                })
            }
            
            NavigationLink(
                destination: TaskView(spaceId: self.model.spaceId, taskId: self.model.taskId),
                isActive: $model.goToTaskView,
                label:{
                    
                })
                .frame(width: 0, height: 0)
                .buttonStyle(PlainButtonStyle())
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.light)
        .navigationTitle(viewUserStore.all[viewId]?.view?.title ?? "ыаыва")
        .navigationBarHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.showSuggestSheet = true
                } label: {
                    Text("Suggest")
                }.sheet(isPresented: $showSuggestSheet, onDismiss:{
                }) {
                    Text("Suggest")
                }
                .background(SolColor.colors().screen.background)
                .preferredColorScheme(.light)
            }
            
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: EditViewPage(viewId: self.viewId)) {
                        Text("Edit")                        
                    }
            }
        }
        .onAppear(perform: {
            self.model.spaceId = ""
            self.model.taskId = ""
            self.model.goToTaskView = false
            self.model.bottomButtonType
            //            self.planningSlotsModel.type = .SPACE
            //            self.addTaskModel.changeView(spaceId: nil, taskId: nil, taskDidCreated: model.taskDidCreated)
            //
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.viewUserStore.syncTaskInView(viewId: viewId)
                self.model.emoji = viewUserStore.all[self.viewId]!.view!.icon!.data!
            }
        })
    }
}



