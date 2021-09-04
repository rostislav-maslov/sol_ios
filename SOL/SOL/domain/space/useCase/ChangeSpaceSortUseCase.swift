//
//  ChangeSpaceSortUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.09.2021.
//

import Foundation

public class ChangeSpaceSortUseCase: UseCase<[SpaceEntity], Bool>{
    let port: SpaceRepositoryPort!
    private let input: Input
    
    init(_ port: SpaceRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping ([SpaceEntity], Bool?) -> Void) {        
        port.changeSortSpace(ChangeSortSpaceRequest(spaces: input.spaces)) { (success: BaseApiResponse<[SpaceResponse]>?, error: BaseApiErrorResponse?, isSuccess: Bool) in
            if success != nil && isSuccess == true {
                callback(SpaceMapping.mapping(response: success!.result), true)
            }else {
                callback([], false)
            }
        }
    }
}

extension ChangeSpaceSortUseCase{
    
    public struct Input{
        var spaces: [String]
    }
    
}
