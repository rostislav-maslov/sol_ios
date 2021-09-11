//
//  TaskTitleModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.09.2021.
//

import Foundation

public class TaskTitleModel: ObservableObject, MultilineTextFieldProtocol{
    var taskStore: TaskStore?
    var taskId: String
    init(taskId: String){        
        self.taskId = taskId
    }
    
    public func textDidChange(text: String){
        taskStore?.tasks[taskId]?.title = text
    }
    public func textEditFinish(text: String){
        taskStore?.saveTitleIcon(taskId: taskId)
    }
    
}
