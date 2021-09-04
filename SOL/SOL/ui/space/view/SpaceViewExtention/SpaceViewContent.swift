//
//  SpaceViewContent.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpaceView {
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { (value:ScrollViewProxy) in
                header
                actionsTitle
                actionsButton
                picker
                pickerContainer.id("endOfScrollView")
                
                    .onAppear {
                        self.model.scrollViewProxy = value
                    }
            }
        }
        .background(SolColor.colors().screen.background)
        .ignoresSafeArea(.all)
        .gesture(
            DragGesture(coordinateSpace: .local)
                .onEnded { value in
                    if value.startLocation.x > .zero && value.startLocation.x < 48{
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            self.navigationStack.pop()
                            print("DragGesture")
                        }
                    }else{
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            if model.activeTab - 1 >= 0 {
                                model.activeTab = model.activeTab - 1
                            }
                            print(model.activeTab)
                            print(value.translation.width)
                        }else{
                            if model.activeTab + 1 <= model.activeTabMax {
                                model.activeTab = model.activeTab + 1
                            }
                            print(model.activeTab)
                            print(value.translation.width)
                        }
                    }
                }
        )
    }
}
