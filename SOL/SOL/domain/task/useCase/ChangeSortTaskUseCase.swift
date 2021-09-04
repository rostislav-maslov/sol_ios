//
//  ChangeSortTaskUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation


public class ChangeSortTaskUseCase: UseCase<[TaskEntity], Bool>{
    let port: TaskRepositoryPort!
    private let input: Input
    
    init(_ port: TaskRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping ([TaskEntity], Bool?) -> Void) {
        let request:ChangeSortTasksRequest = ChangeSortTasksRequest(tasks: self.input.tasks)
        
        port.changeSort(request) { (success: BaseApiResponse<[TaskResponse]>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(TaskMapping.mapping(response: success!.result), true)
            }else{
                callback([], false)
            }
        }
    }
}

extension ChangeSortTaskUseCase{
    
    public struct Input{
        var tasks:[String]
    }
    
}
