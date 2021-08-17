//
//  MakeTaskDoneUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 12.08.2021.
//

import Foundation


public class MakeTaskDoneUseCase: UseCase<TaskEntity, Bool>{
    let port: TaskRepositoryPort!
    let input: Input
    
    init(_ port: TaskRepositoryPort, _ input: Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (TaskEntity?, Bool) -> Void) {
        port.makeDone(input.taskId, responseFunc: { (success:BaseApiResponse<TaskResponse>?, error:BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(TaskMapping.mapping(response: success!.result), true)
            }else {
                callback(nil, false)
            }
        })
    }
}

extension MakeTaskDoneUseCase {
    public struct Input{
        var taskId:String
        
        public static func of(_ taskId:String) -> Input{
            let input:Input = Input(taskId: taskId)
            return input
        }
    }
}
