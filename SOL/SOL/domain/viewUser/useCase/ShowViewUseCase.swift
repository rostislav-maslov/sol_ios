//
//  ShowViewUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.02.2022.
//

import Foundation
import Foundation


public class ShowViewUseCase: UseCase<Bool, Bool>{
    let port: ViewUserRepositoryPort!
    private let input: Input
    
    init(_ port: ViewUserRepositoryPort, input: ShowViewUseCase.Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (Bool, Bool) -> Void) {
        port.show(viewId: input.viewId) { success, error, isSuccess in
            callback(true, true)
        }
    }
}

extension ShowViewUseCase{
    
    public struct Input{
        var viewId: String
    }
    
}
