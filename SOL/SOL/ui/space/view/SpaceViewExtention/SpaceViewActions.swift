//
//  SpaceViewActions.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI


extension SpaceView {
    var actionsTitle:some View {
        VStack{
            //Spacer().frame(width: 1, height: 16, alignment: .center)
            
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

extension SpaceView {
    var actionToggleView: some View {
        VStack{
            if (model.actionToggle == false){
                ActionButtonView(
                    title: "Toggle",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_arrow-tab",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 16,
                    iconHeight: 16,
                    iconVerticalSpace: 4,
                    subTitle: "Show all subtask") {
                        self.model.actionToggle = !self.model.actionToggle
                        taskStore.toggleBySpaceId(spaceId: spaceId, show: true)
                    }
            }else {
                ActionButtonView(
                    title: "Toggle",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_arrow-tab",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Hide all subtask"){
                        self.model.actionToggle = !self.model.actionToggle
                        taskStore.toggleBySpaceId(spaceId: spaceId, show: false)
                }
            }
        }
    }
    
    var planningActionView: some View {
        VStack{
            ActionButtonView(
                title: "Planning",
                titleColor: SolColor.colors().checkBox.undoneBackground,
                icon: "ic_calendar",
                iconColor: SolColor.colors().checkBox.undoneBackground,
                iconWidth: 14,
                iconHeight: 14,
                iconVerticalSpace: 4,
                subTitle: "Your plan 4h"){                        
                    planningSlotsModel.isPresented = true
                }
            
            
        }
    }
    
    var actionsButton: some View {
        VStack{
            Spacer().frame(width: 1, height: 16, alignment: .center)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    VStack {
                        Spacer()
                            .frame(width: 5, height: 10, alignment: .center)
                    }
                    VStack {
                        actionToggleView
                    }
                    VStack {
                        planningActionView
                    }
                    
                    VStack {
                        Spacer()
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                }
            }
            Spacer().frame(width: 1, height: 16, alignment: .center)
        }
    }
}

//struct SpaceActionsView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        SpaceView(model: SpaceViewModel.forRender())
//    }
//}
