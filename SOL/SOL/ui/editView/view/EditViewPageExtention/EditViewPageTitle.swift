//
//  EditViewPageTitle.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.02.2022.
//

import Foundation
import SwiftUI

extension EditViewPage{
    
    var titleContent: some View {
        VStack{
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
                    MultilineTextFieldView(text: model.viewUserEntity.view?.title ?? "", textColor: SolColor.colors().checkBox.undoneBackground, textSize: 24)
                        { textDidChange in
                            model.viewUserEntity.view?.title = textDidChange
                        } textEditFinish: { textEditFinish in
                            model.viewUserEntity.view?.title = textEditFinish
                        } titleSizeDidChange: { titleSize in
                            model.titleSize = titleSize
                        } multilineTextFieldView: { textView in
                        }
                        .font(SolFonts.font(
                                size: 24,
                                weight: Font.Weight.medium,
                                color: SolColor
                                    .colors()
                                    .checkBox
                                    .undoneBackground))
                        .frame(
                            width: nil,
                            height: model.titleSize,
                            alignment: .center)
                        .foregroundColor(
                            SolColor
                                .colors()
                                .checkBox
                                .doneBackground)
                        .onAppear(perform: {

                        })
                })
                
                Spacer().frame(width: 8, height: 1, alignment: .center)
            })
            
            Spacer()
                .frame(width: 0.0, height: 24.0, alignment: Alignment.center)
        }
        .listRowSeparator(Visibility.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(SolColor.colors().screen.background)
    }
    
}
