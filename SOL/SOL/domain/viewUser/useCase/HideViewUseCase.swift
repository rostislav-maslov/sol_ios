//
//  HideViewUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.02.2022.
//

import Foundation


public class HideViewUseCase: UseCase<Bool, Bool>{
    let port: ViewUserRepositoryPort!
    private let input: Input
    
    init(_ port: ViewUserRepositoryPort, input: HideViewUseCase.Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (Bool, Bool) -> Void) {
        port.hide(viewId: input.viewId) { success, error, isSuccess in
            callback(true, true)
        }        
    }
}

extension HideViewUseCase{
    
    public struct Input{
        var viewId: String
    }
    
}
