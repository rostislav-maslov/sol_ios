//
//  TaskItemViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation

public class TaskItemViewModel: ObservableObject {
    @Published var task: TaskEntity
    
    init( task: TaskEntity) {
        self.task = task
    }
}
