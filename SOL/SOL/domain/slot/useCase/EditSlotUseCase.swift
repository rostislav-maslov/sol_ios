//
//  EditSlotUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 18.10.2021.
//

import Foundation


public class EditSlotUseCase: UseCase<SlotEntity, Bool>{
    let port: SlotRepositoryPort!
    private let input: Input
    
    init(_ port: SlotRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (SlotEntity?, Bool?) -> Void) {
        let request: SlotUpdateRequest = SlotUpdateRequest(
            endTime: input.endTime.millisecondsSince1970,
            startTime:  input.startTime.millisecondsSince1970,
            id: input.slotId,
            timezone: input.startTime.timezone
            )
        
        port.edit(request) { (success: BaseApiResponse<SlotResponse>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(SlotMapping.mapping(response: success!.result), true)
            }else{
                callback(nil, false)
            }
        }
    }
}

extension EditSlotUseCase{
    
    public struct Input{
        var slotId: String
        var startTime:  Date
        var endTime: Date
    }
    
}
