//
//  FindByViewUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 14.12.2021.
//

import Foundation

public class FindByViewUseCase: UseCase<[TaskInViewResponse], Bool>{
    let port: ViewUserRepositoryPort!
    private let input: Input
    
    init(_ port: ViewUserRepositoryPort, input: FindByViewUseCase.Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping ([TaskInViewResponse], Bool?) -> Void) {
        port.findByView(viewId: input.viewId) { (success: BaseApiResponse<[TaskInViewResponse]>?,  error:BaseApiErrorResponse?, isSuccess:Bool) in
            if success != nil && isSuccess == true {
                callback(success!.result, true)
            }else{
                callback([], false)
            }
        }
    }
}

extension FindByViewUseCase{
    
    public struct Input{
        var viewId: String
        public static func of(
            viewId: String
        ) -> Input{
            let input:Input = Input(viewId:viewId)
            return input
        }
    }
    
}
