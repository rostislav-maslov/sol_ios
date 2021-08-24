//
//  TaskHeader.swift
//  SOL
//
//  Created by Rostislav Maslov on 12.08.2021.
//

import Foundation
import SwiftUI

extension TaskView{
    var header: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            headerSpacer
            taskTitle
            Spacer().frame(width: 1, height: .infinity, alignment: .center)
        })
    }
}

extension TaskView{
    var taskTitle: some View {
        
        HStack(alignment: .top, spacing: 0, content: {
            Spacer().frame(width: 16, height: 11, alignment: .center)
            VStack{
                Spacer().frame(width: 0, height: 4, alignment: .center)
                CheckBoxView(size: .NORMAL, done: $model.actionDone) {
                    model.toggleTask()
                }
            }
            Spacer().frame(width: 8, height: 1, alignment: .center)
            VStack(alignment: .leading, spacing: 0, content: {
                Spacer().frame(width: 0, height: 4, alignment: .center)
                IconFieldComponent(
                    placeholder: "🪐",
                    value: $model.task.icon.data,
                    state: $model.state, textFieldShouldBeginEditing: {
                        model.bottomButtonType = BottomButtonType.CLOSE_ICON_FIELD
                    }, callbackEmojiTextField: { (emojiTextField:UIEmojiTextField) in
                        model.emojiTextField = emojiTextField
                    })
            })
            
            VStack(alignment: .leading, spacing: 0, content: {
                Spacer().frame(height: 2)
                MultilineTextFieldView(
                    text: $model.task.title,
                    model: multilineTextFieldModel,
                    textColor: UIColor(SolColor.colors().checkBox.undoneBackground),
                    textSize: 24)
                    .font(SolFonts.font(
                            size: 24,
                            weight: Font.Weight.medium,
                            color: SolColor.colors().checkBox.undoneBackground))
                    .frame(width: .infinity, height: multilineTextFieldModel.titleSize, alignment: .center)
                    .foregroundColor(SolColor.colors().checkBox.doneBackground)
            })
            
            Spacer().frame(width: 8, height: 1, alignment: .center)
        })
    }
}


//extension SpaceView {
//    var taskTitle: some View {
//        HStack(alignment: .top, spacing: 0, content: {
//            Spacer().frame(width: 2, height: 11, alignment: .center)
//            VStack(alignment: .leading, spacing: 0, content: {
//                Spacer().frame(width: 0, height: 4, alignment: .center)
//                IconFieldComponent(
//                    placeholder: "🪐",
//                    value: $model.space.icon.data,
//                    state: $model.state, textFieldShouldBeginEditing: {
//                        model.bottomButtonType = BottomButtonType.CLOSE_ICON_FIELD
//                    }, callbackEmojiTextField: { (emojiTextField:UIEmojiTextField) in
//
//                        model.emojiTextField = emojiTextField
//                    })
//            })
//
//            VStack(alignment: .leading, spacing: 0, content: {
//                Spacer().frame(height: 2)
//                MultilineTextFieldView(
//                    text: $model.space.title,
//                    firstSizeTitle: $model.firstSizeTitle,
//                    detectFirstSizeTitle: $model.detectFirstSizeTitle,
//                    textColor: UIColor(SolColor.colors().checkBox.undoneBackground),
//                    textSize: 24, delegate: model)
//                    .font(SolFonts.font(
//                            size: 24,
//                            weight: Font.Weight.medium,
//                            color: SolColor.colors().checkBox.undoneBackground))
//                    .frame(width: .infinity, height: model.titleSize, alignment: .center)
//                    .foregroundColor(SolColor.colors().checkBox.doneBackground)
//            })
//            Spacer().frame(width: 8, height: 1, alignment: .center)
//        })
//    }
//}

extension TaskView {
    var actionsTitle:some View {
        VStack{
            Spacer().frame(width: 1, height: 16, alignment: .center)
            
            HStack(alignment: .center){
                Spacer()
                    .frame(width: 12, height: 0, alignment: .center)
                IconComponent(size: 24, icon: "⚙️")
                Spacer()
                    .frame(width: 8, height: 0, alignment: .center)
                Text("Actions")
                    .font(
                        SolFonts.font(
                            size: 24,
                            weight: Font.Weight.medium,
                            color: SolColor.colors().fontColors.normal))
                Spacer()
                Spacer().frame(width: 16, height: 0, alignment: .center)
            }
        }
    }
}


extension TaskView {
    var headerSpacer: some View {
        HStack{
            Spacer()
                .frame(
                    width: .infinity,
                    height: (41 + 41 + 34),
                    alignment: .center)
        }
    }
}
