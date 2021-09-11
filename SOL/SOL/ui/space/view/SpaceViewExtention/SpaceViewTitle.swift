//
//  SpaceViewTitle.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpaceView {
    var taskTitle: some View {
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 2, height: 11, alignment: .center)
            VStack(alignment: .leading, spacing: 0, content: {
                Spacer().frame(width: 0, height: 2, alignment: .center)
                IconFieldComponent(
                    placeholder: "🪐",
                    spaceId: self.spaceId,
                    textFieldShouldBeginEditing: {
                        model.bottomButtonType = BottomButtonType.CLOSE_ICON_FIELD
                    },
                    callbackEmojiTextField: { (emojiTextField:UIEmojiTextField) in
                        self.model.emojiTextField = emojiTextField
                    })
            })
            
            VStack(alignment: .leading, spacing: 0, content: {
                SpaceTitleView(spaceId: self.model.spaceId)
//                MultilineTextFieldView(
//                    text: model.space.title,
//                    model: multilineTextFieldModel,
//                    textColor: UIColor(SolColor.colors().checkBox.undoneBackground),
//                    textSize: 24)
//                    .font(SolFonts.font(
//                            size: 24,
//                            weight: Font.Weight.medium,
//                            color: SolColor.colors().checkBox.undoneBackground))
//                    .frame(
//                        height: multilineTextFieldModel.titleSize
//                        )
//                    .foregroundColor(SolColor.colors().checkBox.doneBackground)
            })
        
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}

struct SpaceTitleView_Previews: PreviewProvider {
    
    static var previews: some View {
        SpaceView(spaceId: SpaceViewModel("1111").spaceId)
    }
}

