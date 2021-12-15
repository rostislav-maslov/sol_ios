//
//  ViewWithTasksModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 14.12.2021.
//

import Foundation
import Combine

public class ViewWithTasksModel: NSObject, ObservableObject{
    
    @Published var isTarget = true
    @Published var taskId = ""
    @Published var spaceId = ""
    @Published var goToTaskView = false
    @Published var placeholder: String = "🪐"
    @Published var emoji: String = "🪐"
    @Published var stopEditIcon = false
    @Published var actionToggle = false
    @Published var bottomButtonType = BottomButtonType.CLOSE_ICON_FIELD
}

extension ViewWithTasksModel {
   
}

