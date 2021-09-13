//
//  SpaceView.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import NavigationStack



public struct SpaceView: View {
    var spaceId: String
    @ObservedObject var model: SpaceViewModel    
    @EnvironmentObject var navigationStack: NavigationStack
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    
    @State public var isEditable = true
    @State var isTarget = true
    
    var emojiTextField: EmojiTextField?    
    
    init(spaceId: String){
        self.spaceId = spaceId
        self.model = SpaceViewModel(spaceId)
    }
    
    public var body: some View {        
        ZStack {
            content
                
            SolNavigationView()
            if model.bottomButtonType == BottomButtonType.ADD_TASK {
                AddTaskRootView(
                    spaceId: self.spaceId,
                    parentTaskId: nil,
                    taskDidCreated: {
                    withAnimation {
                        self.model.scrollViewProxy?
                            .scrollTo(
                                "endOfScrollView",
                                anchor: .bottom)
                    }
                })
            }
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {                                        
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                    model.emojiTextField?.endEditing(true)
                    spaceStore.saveTitleIcon(
                        spaceId: spaceId,
                        title: spaceStore.spaces[spaceId]!.title,
                        data: spaceStore.spaces[spaceId]!.icon.data)
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.light)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.spaceStore.sync(spaceId: self.spaceId)
            }
        })
    }
}

struct SpaceView_Previews: PreviewProvider {
    
    static var previews: some View {
        SpaceView(spaceId: SpaceViewModel.forRender().spaceId)
    }
}

