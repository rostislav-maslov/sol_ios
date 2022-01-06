//
//  TaskAllUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 06.01.2022.
//


import Foundation

public class TaskAllUseCase: UseCase<[TaskEntity], Bool>{
    let port: TaskRepositoryPort!
    
    init(_ port: TaskRepositoryPort) {
        self.port = port
    }
    
    override public func execute(_ callback: @escaping ([TaskEntity], Bool) -> Void) {
        port.findAll(responseFunc: { (success:BaseApiResponse<[TaskResponse]>?, error:BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(TaskMapping.mapping(response: success!.result), true)
            }else {
                callback([], false)
            }
        })
    }
}

