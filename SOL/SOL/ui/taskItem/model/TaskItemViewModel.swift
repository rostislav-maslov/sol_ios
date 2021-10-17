//
//  TaskItemViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation
import Combine

public class TaskItemViewModel: ObservableObject {
    
    @Published var taskId:String = ""
    var taskStore: TaskStore?
    
    @Published var target: Bool = true
    
}


