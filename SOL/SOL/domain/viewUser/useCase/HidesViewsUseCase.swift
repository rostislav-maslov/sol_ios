//
//  HidesViewsUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.02.2022.
//

import Foundation


public class HidesViewsUseCase: UseCase<[ViewUserEntity], Bool>{
    let port: ViewUserRepositoryPort!
    private let input: Input
    
    init(_ port: ViewUserRepositoryPort, input: HidesViewsUseCase.Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping ([ViewUserEntity], Bool?) -> Void) {
        port.viewAll { (success, error, isSuccess) in
            let allSuccess = success
            if success == nil {
                callback([], false)
                return
            }
            
            self.port.myRoot { (success: BaseApiResponse<[ViewUserResponse]>?,  error:BaseApiErrorResponse?, isSuccess:Bool) in
                if success != nil && isSuccess == true {
                    var hides:[ViewUserResponse] = []
                    for view in allSuccess!.result {
                        var needAdd = true
                        for  viewCheck in success!.result {
                            if viewCheck.id == view.id {
                                needAdd = false
                            }
                        }
                        if needAdd == true {
                            hides.append(view)
                        }
                        
                    }
                    callback(ViewUserMapping.mapping(response: hides), true)
                }else{
                    callback([], false)
                }
            }
        }
    }
}

extension HidesViewsUseCase{
    
    public struct Input{
        public static func of(
            
        ) -> Input{
            let input:Input = Input()
            return input
        }
    }
    
}
