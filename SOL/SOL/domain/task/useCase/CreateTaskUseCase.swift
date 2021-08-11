//
//  CreateSpaceUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.08.2021.
//

import Foundation

public class CreateTaskUseCase: UseCase<TaskEntity, Bool>{
    let port: TaskRepositoryPort!
    private let input: Input
    
    init(_ port: TaskRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (TaskEntity?, Bool?) -> Void) {
        let request:TaskCreateRequest = TaskCreateRequest(
            icon: IconResponse(data: input.emoji, type: "EMOJI"),
            parentTaskId: input.parentTaskId,
            spaceId: input.spaceId,
            title: input.title)
        
        port.create(request) { (success: BaseApiResponse<TaskResponse>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(TaskMapping.mapping(response: success!.result), true)
            }else{
                callback(nil, false)
            }
        }              
    }
}

extension CreateTaskUseCase{
    
    public struct Input{
        var title:String
        var emoji:String?
        var parentTaskId:String?
        var spaceId: String?
        
        public static func of(
            _ title:String,
            _ emoji: String,
            _ parentTaskId:String?,
            _ spaceId: String?
        ) -> Input{
            var input:Input = Input(title:title)
            input.title = title
            input.emoji = emoji
            input.parentTaskId = parentTaskId
            input.spaceId = spaceId
            
            return input
        }
    }
    
}
