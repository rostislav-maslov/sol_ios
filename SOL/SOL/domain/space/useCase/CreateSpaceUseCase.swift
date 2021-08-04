//
//  CreateSpaceUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.08.2021.
//

import Foundation

public class CreateSpaceUseCase: UseCase<SpaceEntity, Bool>{
    let port: SpaceRepositoryPort!
    private let input: Input
    
    init(_ port: SpaceRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (SpaceEntity?, Bool?) -> Void) {
        let request:SpaceCreateRequest = SpaceCreateRequest(title: input.title!, icon: input.emoji!)
        
        port.create(request, responseFunc: { (success: BaseApiResponse<SpaceResponse>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(SpaceMapping.mapping(response: success!.result), true)
            }else {
                callback(nil, false)
            }
        })                               
    }
}

extension CreateSpaceUseCase{
    
    public struct Input{
        var title:String?
        var emoji:String?
        
        public static func of(_ title:String, _ emoji: String) -> Input{
            var input:Input = Input()
            input.title = title
            input.emoji = emoji
            
            return input
        }
    }
    
}
