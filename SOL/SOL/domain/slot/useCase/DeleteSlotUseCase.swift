//
//  DeleteSlotUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 18.10.2021.
//

import Foundation

public class DeleteSlotUseCase: UseCase<String, Bool>{
    let port: SlotRepositoryPort!
    private let input: Input
    
    init(_ port: SlotRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (String?, Bool?) -> Void) {
        port.delete(input.slotId) { (success: BaseApiResponse<String>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(success!.result, true)
            }else{
                callback(nil, false)
            }
        }
    }
}

extension DeleteSlotUseCase{
    
    public struct Input{
        var slotId: String
    }
    
}
