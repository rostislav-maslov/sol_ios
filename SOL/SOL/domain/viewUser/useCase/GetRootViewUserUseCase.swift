//
//  GetRootViewUserUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation


public class GetRootViewUserUseCase: UseCase<[ViewUserEntity], Bool>{
    let port: ViewUserRepositoryPort!
    private let input: Input
    
    init(_ port: ViewUserRepositoryPort, input: GetRootViewUserUseCase.Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping ([ViewUserEntity], Bool?) -> Void) {
        
        port.myRoot { (success: BaseApiResponse<[ViewUserResponse]>?,  error:BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(ViewUserMapping.mapping(response: success != nil ? success!.result : []), true)
            }else{
                callback([], false)
            }
        }
    }
}

extension GetRootViewUserUseCase{
    
    public struct Input{
        public static func of(
            
        ) -> Input{
            let input:Input = Input()
            return input
        }
    }
    
}
