//
//  ViewTitleView.swift
//  SOL
//
//  Created by Rostislav Maslov on 15.12.2021.
//

import Foundation
import SwiftUI

struct ViewTitleView: View {
    var viewUserId: String
    @EnvironmentObject var viewUserStore: ViewUserStore
    @StateObject var model: ViewTitleModel = ViewTitleModel()
    @State var titleSize: CGFloat = 44
    
    init(viewUserId : String){
        self.viewUserId = viewUserId
    }
    
    var body: some View {
        
        MultilineTextFieldView(text: viewUserStore.all[viewUserId] != nil ? viewUserStore.all[viewUserId]!.view!.title! : "", textColor: SolColor.colors().checkBox.undoneBackground, textSize: 24)
            { textDidChange in
                viewUserStore.all[viewUserId]?.view!.title = textDidChange
            } textEditFinish: { textEditFinish in
                viewUserStore.all[viewUserId]?.view!.title = textEditFinish
                // taskStore.saveTitleIcon(taskId: taskId, title: textEditFinish, iconData: taskStore.tasks[taskId]!.icon.data)
            } titleSizeDidChange: { titleSize in
                self.titleSize = titleSize
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
                height: titleSize,
                alignment: .center)
            .foregroundColor(
                SolColor
                    .colors()
                    .checkBox
                    .doneBackground)
            .onAppear(perform: {
                
            })
        
        
    }
}



//struct TaskTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskTitleView()
//    }
//}

