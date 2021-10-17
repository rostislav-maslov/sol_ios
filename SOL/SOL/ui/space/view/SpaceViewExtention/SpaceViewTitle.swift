//
//  SpaceViewTitle.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI


extension SpaceView {
    var taskTitle: some View {
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 2, height: 11, alignment: .center)
            VStack(alignment: .leading, spacing: 0, content: {
                Spacer().frame(width: 0, height: 2, alignment: .center)
                IconFieldComponent(
                    placeholder: $placeholder,
                    emoji: $model.emoji,
                    stopEditing: $model.stopEditIcon) {
                        addTaskModel.state = .HIDDEN
                        model.bottomButtonType = .CLOSE_ICON_FIELD
                }
            })
            
            VStack(alignment: .leading, spacing: 0, content: {
                SpaceTitleView(spaceId: self.spaceId)
            })
        
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}

struct SpaceTitleView_Previews: PreviewProvider {
    
    static var previews: some View {
        SpaceView(spaceId: SpaceViewModel().spaceId!)
    }
}

