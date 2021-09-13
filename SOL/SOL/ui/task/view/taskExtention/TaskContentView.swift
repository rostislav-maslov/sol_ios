//
//  TaskItemView.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import SwiftUI


extension TaskView {
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { (value:ScrollViewProxy) in
                header
                actionsTitle
                actionsButton
                picker
                pickerContainer.id("endOfScrollViewTasks")
                    
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
                            
                            //self.goBack.ppp().wrappedValue.dismiss()
                            print("DragGesture")
                        }
                    }else{
                        if value.translation.width > .zero
                            && value.translation.height > -30
                            && value.translation.height < 30 {
                            if self.model.activeTab - 1 >= 0 {
                                self.model.activeTab = self.model.activeTab - 1
                            }
                            print(self.model.activeTab)
                            print(value.translation.width)
                        }else{
                            if self.model.activeTab + 1 <= self.model.activeTabMax {
                                self.model.activeTab = self.model.activeTab + 1
                            }
                            print(self.model.activeTab)
                            print(value.translation.width)
                        }
                    }
                }
        )
    }
}







