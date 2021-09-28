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
        var request:TaskCreateRequest = TaskCreateRequest(
            icon: IconResponse(data: input.emoji, type: "EMOJI"),
            parentTaskId: input.parentTaskId,
            spaceId: input.spaceId,
            title: input.title)
        
        request.deadlineType = input.deadlineType?.rawValue
        request.deadline = input.deadline?.millisecondsSince1970
        request.timezone = Date().timezone
        
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
        var deadline: Date?
        var deadlineType: DeadlineType?
        var timezone: Int?
        
        public static func of(
            _ title:String,
            _ emoji: String,
            _ parentTaskId:String?,
            _ spaceId: String?,
            _  deadline: Date?,
            _  deadlineType: DeadlineType?,
            _  timezone: Int?
        ) -> Input{
            var input:Input = Input(title:title)
            input.title = title
            input.emoji = emoji
            input.parentTaskId = parentTaskId
            input.spaceId = spaceId
            input.deadline = deadline
            input.deadlineType = deadlineType
            input.timezone = timezone
            
            return input
        }
    }
    
}
