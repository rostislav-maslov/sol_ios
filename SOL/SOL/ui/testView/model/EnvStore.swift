//
//  EnvStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import Foundation
import Combine

public class EnvStore: ObservableObject {
    @Published var tasks:[Int: TaskEntity] = [Int: TaskEntity]()
    
    func generate(){
        print("start generate")
        for _ in 0...10000 {
            self.inc()
        }
        print("start recount")
        for index in 0...tasks.count {
            tasks[index]?.title = "\(index) / \(tasks.count)"
        }
        print("finish recount")
    }
    
    func inc(){
        let count = tasks.count
        let task = TaskEntity();
        task.id = "\(count)"
        task.title = "\(count)"
        self.tasks[count] =  task
    }
}
