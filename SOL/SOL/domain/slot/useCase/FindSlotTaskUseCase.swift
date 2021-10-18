//
//  FindSlotTaskUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 18.10.2021.
//

import Foundation

public class FindSlotTaskUseCase: UseCase<[SlotEntity], Bool>{
    let port: SlotRepositoryPort!
    private let input: Input
    
    init(_ port: SlotRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping ([SlotEntity], Bool?) -> Void) {
        
        port.findByTaskId(input.taskId) { (success: BaseApiResponse<[SlotResponse]>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(SlotMapping.mapping(response: success != nil ? success!.result : []), true)
            }else{
                callback([], false)
            }
        }
    }
}

extension FindSlotTaskUseCase{
    
    public struct Input{
        var taskId: String
    }
    
}
