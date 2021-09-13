//
//  TaskTitleModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.09.2021.
//

import Foundation

public class TaskTitleModel: ObservableObject{
    var taskStore: TaskStore?
    var taskId: String
    init(taskId: String){        
        self.taskId = taskId
    }
    
   
    
}
