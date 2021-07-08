//
//  UseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation

public class UseCase<ResponseSuccess, ResponseFailure>: UseCaseProtocol {
    public func execute(_ callback: @escaping (ResponseSuccess?, ResponseFailure?) -> Void) {
        fatalError()
    }
}
