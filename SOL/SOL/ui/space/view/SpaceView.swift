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
    @ObservedObject var model: SpaceViewModel
    @ObservedObject var multilineTextFieldModel:MultilineTextFieldModel = MultilineTextFieldModel()
    @EnvironmentObject var navigationStack: NavigationStack
    @State public var isEditable = true
    @State var isTarget = true
    init(model: SpaceViewModel){
        self.model = model
        self.multilineTextFieldModel.delegate = model        
    }
    
    public var body: some View {        
        ZStack {
            content
            SolNavigationView()
            if model.bottomButtonType == BottomButtonType.ADD_TASK {
                AddTaskRootView(
                    model: AddTaskViewModel(
                        model.spaceId,
                        parentTaskId: nil,
                        taskDidCreated: model.taskDidCreated),
                    parentTitle: $model.space.title)
            }
            if model.bottomButtonType == BottomButtonType.CLOSE_ICON_FIELD {
                DoneKeyboardButtonView(action: {
                    model.saveTitleIcon()
                    model.emojiTextField?.endEditing(false)
                    model.bottomButtonType = BottomButtonType.ADD_TASK
                })
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        .onAppear(perform: {
            self.model.load()
        })
    }
}

struct SpaceView_Previews: PreviewProvider {
    
    static var previews: some View {
        SpaceView(model: SpaceViewModel.forRender())
    }
}

