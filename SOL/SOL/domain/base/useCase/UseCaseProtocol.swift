//
//  UseCaseProtocol.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation
public protocol UseCaseProtocol{
    associatedtype ResponseSuccess
    associatedtype ResponseFailure
    func execute(_ callback: @escaping (_ success:ResponseSuccess?, _ error:ResponseFailure?) -> Void)
}
