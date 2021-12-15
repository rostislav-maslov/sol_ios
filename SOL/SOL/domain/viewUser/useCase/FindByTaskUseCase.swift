//
//  FindByTaskUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.12.2021.
//

import Foundation



public class FindByTaskUseCase: UseCase<[TaskInViewResponse], Bool>{
    let port: ViewUserRepositoryPort!
    private let input: Input
    
    init(_ port: ViewUserRepositoryPort, input: FindByTaskUseCase.Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping ([TaskInViewResponse], Bool?) -> Void) {
        port.findByTask(taskId: input.taskId) { (success: BaseApiResponse<[TaskInViewResponse]>?,  error:BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                
                callback(success!.result, true)
            }else{
                callback([], false)
            }
        }
    }
}

extension FindByTaskUseCase{
    
    public struct Input{
        var taskId: String
        public static func of(
            taskId: String
        ) -> Input{
            let input:Input = Input(taskId:taskId)
            return input
        }
    }
    
}
