//
//  MySpacesUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.08.2021.
//

import Foundation

public class MySpacesUseCase: UseCase<[SpaceEntity], Bool>{
    let port: SpaceRepositoryPort!
    
    init(_ port: SpaceRepositoryPort) {
        self.port = port
    }
    
    override public func execute(_ callback: @escaping ([SpaceEntity], Bool?) -> Void) {
        port.mySpaces { (success: BaseApiResponse<[SpaceResponse]>?, error: BaseApiErrorResponse?, isSuccess: Bool) in
            if success != nil && isSuccess == true {
                callback(SpaceMapping.mapping(response: success!.result), true)
            }else {
                callback([], false)
            }
        }                        
    }
}

