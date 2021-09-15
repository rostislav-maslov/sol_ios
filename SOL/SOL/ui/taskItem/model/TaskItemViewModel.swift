//
//  TaskItemViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation
import Combine

public class TaskItemViewModel: ObservableObject {
    
    var taskId:String
    var taskStore: TaskStore?
    
    @Published var target: Bool = true
    
    init( taskId: String){
        self.taskId = taskId
    }
    
    func toggle(){
        taskStore!.tasks[taskId]!.showSubtask = !taskStore!.tasks[taskId]!.showSubtask
    }
}


