//
//  TaskItemViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation

class TaskItemViewModel: ObservableObject {
    @Published var taskEntity: TaskEntity = TaskEntity()
}
