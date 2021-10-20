//
//  SpacesViewActions.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation
import SwiftUI

extension SpacesView {
    var actionButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                VStack {
                    Spacer()
                        .frame(width: 5, height: 10, alignment: .center)
                }
                ActionButtonView(
                    title: "Planning",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "ic_calendar",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Open calendar") {
                        planningSlotsModel.isPresented = true
                    }
                ActionButtonView(
                    title: "Notification",
                    titleColor: SolColor.colors().checkBox.undoneBackground,
                    icon: "notification",
                    iconColor: SolColor.colors().checkBox.undoneBackground,
                    iconWidth: 14,
                    iconHeight: 14,
                    iconVerticalSpace: 4,
                    subTitle: "Show all reminders"
                )
                VStack {
                    Spacer()
                        .frame(width: 10, height: 10, alignment: .center)
                }
                
            }
        }
    }
}
