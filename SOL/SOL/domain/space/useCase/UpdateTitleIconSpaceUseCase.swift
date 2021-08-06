//
//  UpdateSpaceUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 06.08.2021.
//

import Foundation

public class UpdateTitleIconSpaceUseCase: UseCase<SpaceEntity, Bool>{
    let port: SpaceRepositoryPort!
    private let input: Input
    
    init(_ port: SpaceRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (SpaceEntity?, Bool?) -> Void) {
        let request:SpaceUpdateRequest = SpaceUpdateRequest.of(input.id, input.title, input.emoji)
        
        port.updateTitleIcon(request, { (success: BaseApiResponse<SpaceResponse>?, error: BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(SpaceMapping.mapping(response: success!.result), true)
            }else {
                callback(nil, false)
            }
        })
    }
}

extension UpdateTitleIconSpaceUseCase{
    
    public struct Input{
        var id: String
        var title: String
        var emoji: String
    }
    
}
