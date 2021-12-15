//
//  ViewWithTasksViewTitle.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.12.2021.
//

import Foundation

import SwiftUI


extension ViewWithTasksView {
    var taskTitle: some View {
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 2, height: 11, alignment: .center)
            VStack(alignment: .leading, spacing: 0, content: {
                Spacer().frame(width: 0, height: 2, alignment: .center)
                IconFieldComponent(
                    placeholder: $model.placeholder,
                    emoji: $model.emoji,
                    stopEditing: $model.stopEditIcon) {
                        addTaskModel.state = .HIDDEN
                        model.bottomButtonType = .CLOSE_ICON_FIELD
                }
            })
            
            VStack(alignment: .leading, spacing: 0, content: {
                ViewTitleView(viewUserId: self.viewId)                
            })
        
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}
