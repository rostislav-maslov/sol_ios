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
    @ObservedObject var model: SpaceViewModel
    
    @EnvironmentObject var taskStore: TaskStore
    @EnvironmentObject var spaceStore: SpaceStore
    
    @State public var isEditable = true
    @State var isTarget = true
    
    @Environment(\.presentationMode) var presentationMode
    
    var emojiTextField: EmojiTextField?    
    
    init(spaceId: String){
        self.spaceId = spaceId
        self.model = SpaceViewModel(spaceId)
        
        UINavigationBar.appearance().titleTextAttributes = [
                   .font : UIFont(name: "HelveticaNeue-Thin", size: 0)!]
    }
    
    public var body: some View {        
        ZStack {
            content
                
            
            AddTaskRootView(spaceId: self.spaceId, parentTaskId: nil) {
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
        .navigationTitle(spaceStore != nil ? (spaceStore.spaces[spaceId]?.title ?? "") : "" )
        .navigationBarHidden(false)
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

