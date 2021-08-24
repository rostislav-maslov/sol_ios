//
//  EditTitleAndIconTaskUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 24.08.2021.
//

import Foundation


public class EditTitleAndIconTaskUseCase: UseCase<TaskEntity, Bool>{
    let port: TaskRepositoryPort!
    private let input: Input
    
    init(_ port: TaskRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (TaskEntity?, Bool?) -> Void) {
        let request:EditTitleAndIconTaskRequest = EditTitleAndIconTaskRequest(
            id: input.id,
            title: input.title,
            icon: IconResponse(data: input.emoji, type: "EMOJI"))
        
        port.editTitleAndIcon(request) { (success: BaseApiResponse<TaskResponse>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(TaskMapping.mapping(response: success!.result), true)
            }else{
                callback(nil, false)
            }
        }
    }
}

extension EditTitleAndIconTaskUseCase{
    
    public struct Input{
        var id:String
        var title:String
        var emoji:String?
        
        public static func of(
            _ id:String,
            _ title:String,
            _ emoji: String
        ) -> Input{
            var input:Input = Input(id:id,title:title)
            input.title = title
            input.emoji = emoji
            
            return input
        }
    }
    
}
