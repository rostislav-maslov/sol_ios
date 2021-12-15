//
//  DeleteTaskInViewUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.12.2021.
//

import Foundation


public class DeleteTaskInViewUseCase: UseCase<String, Bool>{
    let port: ViewUserRepositoryPort!
    private let input: Input
    
    init(_ port: ViewUserRepositoryPort, input: DeleteTaskInViewUseCase.Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (String, Bool?) -> Void) {
        port.deleteTaskInView(taskId: input.taskId, viewId: input.viewId) { (success: BaseApiResponse<Bool>?,  error:BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(self.input.viewId, true)
            }else{
                callback(self.input.viewId, false)
            }
        }
    }
}

extension DeleteTaskInViewUseCase{
    
    public struct Input{
        var taskId: String
        var viewId: String
    }
    
}
