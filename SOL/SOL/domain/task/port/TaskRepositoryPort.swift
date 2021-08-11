//
//  TaskRepositoryPort.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.08.2021.
//

import Foundation

protocol TaskRepositoryPort{
    func create(_ request: TaskCreateRequest, responseFunc: @escaping ApiResponseProtocol<TaskResponse>)
}
