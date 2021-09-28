//
//  AddTaskTextButtonLinesView.swift
//  SOL
//
//  Created by Rostislav Maslov on 25.09.2021.
//

import SwiftUI

extension AddTaskTextView{
    var buttonsLine: some View {
        HStack(spacing: 24) {
            TaskFieldButtonComponent(
                imageName: "ic_calendar",
                title: "planning",
                
                choosed: $model.buttonState.hasSlots,
                didTouch: model.goToPlanning
            )
            
            TaskFieldButtonComponent(
                imageName: "notification",
                title: "notification",
                
                choosed: $model.buttonState.hasNotification,
                didTouch: model.goToNotification
            )
            
            TaskFieldButtonComponent(
                imageName: "deadline",
                title: "Deadline",
                
                choosed: $model.buttonState.hasDeadline,
                didTouch:model.goToDeadline
            )
            
            TaskFieldButtonComponent(
                imageName: "repeat",
                title: "repeat",
                
                choosed: $model.buttonState.hasRepeat,
                didTouch: model.goToRepeat
            )
        }
    }
}
