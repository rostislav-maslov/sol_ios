//
//  SpaceUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation

public class SpaceUseCase: UseCase<SpaceEntity, Bool>{
    let port: SpaceRepositoryPort!
    let input: Input
    
    init(_ port: SpaceRepositoryPort, _ input: Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (SpaceEntity?, Bool) -> Void) {
        port.space(self.input.spaceId) { (success: BaseApiResponse<SpaceResponse>?, error: BaseApiErrorResponse?, isSuccess: Bool) in
            if success != nil && isSuccess == true {
                callback(SpaceMapping.mapping(response: success!.result), true)
            }else {
                callback(nil, false)
            }
        }
    }
}

extension SpaceUseCase {
    public struct Input{
        var spaceId:String
        public static func of(_ spaceId:String) -> Input{
            let input:Input = Input(spaceId: spaceId)
            return input
        }
    }
}
