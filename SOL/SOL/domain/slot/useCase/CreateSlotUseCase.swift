//
//  CreateSlotUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.10.2021.
//

import Foundation


public class CreateSlotUseCase: UseCase<SlotEntity, Bool>{
    let port: SlotRepositoryPort!
    private let input: Input
    
    init(_ port: SlotRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (SlotEntity?, Bool?) -> Void) {
        let request: SlotCreateRequest = SlotCreateRequest(
            endTime: input.endTime.millisecondsSince1970,
            startTime: input.startTime.millisecondsSince1970,
            taskId: input.taskId,
            timezone: Date().timezone)
        
        port.create(request) { (success: BaseApiResponse<SlotResponse>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(SlotMapping.mapping(response: success!.result), true)
            }else{
                callback(nil, false)
            }
        }
    }
}

extension CreateSlotUseCase{
    
    public struct Input{
        var taskId: String
        var startTime:  Date
        var endTime: Date
    }
    
}
