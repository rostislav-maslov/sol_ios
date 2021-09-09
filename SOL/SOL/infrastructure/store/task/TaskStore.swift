//
//  TaskStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import Foundation
import Combine

public class TaskStore: ObservableObject {
    @Published var tasks:[String: TaskEntity] = [String: TaskEntity]()
    
    
}

extension TaskStore {
    func syncTask(taskId: String){
        
    }
}
