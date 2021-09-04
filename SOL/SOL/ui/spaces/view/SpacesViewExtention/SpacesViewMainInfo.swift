//
//  SpacesViewMainInfo.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpacesView{
    var mainInfo: some View {
        VStack{
            HeaderComponent(value: "username") {                    }
            StoriesComponent()
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            TaskTitleComponent(icon: "🤘", title: "Your SOL", showAddButton: false, addButtonDidTouch: nil)
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            actionButtons
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            TaskTitleComponent(icon: "🧑‍🚀", title: "Spaces", showAddButton: true) {
                model.onAddSpacesTouch()
            }
            Spacer().frame(width: 1, height: 16, alignment: .center)
            
        }
    }
}
