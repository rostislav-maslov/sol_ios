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
    @ObservedObject var multilineTextFieldModel:MultilineTextFieldModel = MultilineTextFieldModel()
    @EnvironmentObject var spaceStore: SpaceStore
    @ObservedObject var model: SpaceTitleModel
    
    init(spaceId : String){
        self.spaceId = spaceId
        self.model = SpaceTitleModel(spaceId: spaceId)
        self.multilineTextFieldModel.delegate = self.model
    }
    
    var body: some View {
        MultilineTextFieldView(
            text: spaceStore.spaces[spaceId]!.title,
            model: multilineTextFieldModel,
            textColor: UIColor(SolColor.colors().checkBox.undoneBackground),
            textSize: 24)
            .font(SolFonts.font(
                    size: 24,
                    weight: Font.Weight.medium,
                    color: SolColor.colors().checkBox.undoneBackground))
            .frame(
                height: multilineTextFieldModel.titleSize
                )
            .foregroundColor(SolColor.colors().checkBox.doneBackground)
        
            .onAppear(perform: {
                self.model.spaceStore = spaceStore
            })
    }
}



//struct SpaceTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskTitleView()
//    }
//}

