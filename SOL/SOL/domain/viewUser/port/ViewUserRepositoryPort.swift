//
//  ViewUserRepositoryPort.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation

protocol ViewUserRepositoryPort{    
    func myRoot(responseFunc: @escaping ApiResponseProtocol<[ViewUserResponse]>)
}
