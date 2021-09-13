//
//  SpaceTitleView.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.09.2021.
//

import Foundation
import SwiftUI

struct SpaceTitleView: View {
    var spaceId: String
    
    @EnvironmentObject var spaceStore: SpaceStore
    @ObservedObject var model: SpaceTitleModel
    
    @State var titleSize: CGFloat = 44.0
    
    init(spaceId : String){
        self.spaceId = spaceId
        self.model = SpaceTitleModel(spaceId: spaceId)
        
    }
    
    var body: some View {
        VStack{
            MultilineTextFieldView(text: spaceStore.spaces[spaceId]!.title,
                                   textColor: SolColor.colors().checkBox.undoneBackground,
                                   textSize: 24)
            { textDidChange in
                spaceStore.spaces[spaceId]?.title = textDidChange
            } textEditFinish: { textEditFinish in
                spaceStore.spaces[spaceId]?.title = textEditFinish
                spaceStore.saveTitleIcon(spaceId: spaceId, title: textEditFinish, data: spaceStore.spaces[spaceId]!.icon.data)
            } titleSizeDidChange: { titleSize in
                print("SpaceTitleView - \(titleSize)")
                self.titleSize = titleSize
            } multilineTextFieldView: { textView in
                
            }
            .font(SolFonts.font(
                    size: 24,
                    weight: Font.Weight.medium,
                    color: SolColor.colors().checkBox.undoneBackground))
            .frame(
                height: self.titleSize
            )
            .foregroundColor(SolColor.colors().checkBox.doneBackground)                        
            //.id("SpaceTitleView_" + spaceStore.spaces[spaceId]!.lastUpdateUUID.uuidString)
         
        }
        .frame(
            height: self.titleSize
        )
        .onAppear(perform: {
            self.model.spaceStore = spaceStore
            //self.model.title = spaceStore.spaces[spaceId]!.title
        })
        
        
    }
}



//struct SpaceTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskTitleView()
//    }
//}

