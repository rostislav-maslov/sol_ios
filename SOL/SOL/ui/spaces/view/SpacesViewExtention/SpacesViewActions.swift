//
//  SpacesViewActions.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpacesView {
    var actionButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                VStack {
                    Spacer()
                        .frame(width: 5, height: 10, alignment: .center)
                }
                VStack {
                    ActionButtonView(
                        title: "Done",
                        titleColor: SolColor.colors().actionButton.taskDone,
                        icon: "ic_check_done",
                        iconColor: SolColor.colors().actionButton.taskDone,
                        iconWidth: 14,
                        iconHeight: 14,
                        iconVerticalSpace: 4,
                        subTitle: "Go back to work"
                    )
                    ActionButtonView(
                        title: "Done",
                        titleColor: SolColor.colors().actionButton.taskDone,
                        icon: "ic_check_done",
                        iconColor: SolColor.colors().actionButton.taskDone,
                        iconWidth: 14,
                        iconHeight: 14,
                        iconVerticalSpace: 4,
                        subTitle: "Go back to work"
                    )
                }
                VStack {
                    Spacer()
                        .frame(width: 10, height: 10, alignment: .center)
                }
                
            }
        }
    }
}
