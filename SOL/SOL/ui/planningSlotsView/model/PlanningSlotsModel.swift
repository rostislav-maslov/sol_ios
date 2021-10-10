//
//  SlotsCalendarModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.10.2021.
//

import Foundation
import Combine
import SwiftUI

public class PlanningSlotsModel: NSObject, ObservableObject {
    var taskId: String
    var taskStore: TaskStore?
    
    
    
    private var disposables = Set<AnyCancellable>()
    private let port:SlotRepositoryPort = SolApiService.api().slot
    
    init(taskId: String){
        self.taskId = taskId
    }
}

