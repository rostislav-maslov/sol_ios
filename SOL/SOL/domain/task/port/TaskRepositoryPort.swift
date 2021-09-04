//
//  TaskRepositoryPort.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.08.2021.
//

import Foundation

protocol TaskRepositoryPort{
    func create(_ request: TaskCreateRequest, responseFunc: @escaping ApiResponseProtocol<TaskResponse>)
    func editTitleAndIcon(_ request: EditTitleAndIconTaskRequest, responseFunc: @escaping ApiResponseProtocol<TaskResponse>)
    func findById(_ id: String, responseFunc: @escaping ApiResponseProtocol<TaskResponse>)
    func makeDone(_ id: String, responseFunc: @escaping ApiResponseProtocol<TaskResponse>)
    func makeOpen(_ id: String, responseFunc: @escaping ApiResponseProtocol<TaskResponse>)
    func changeSort(_ request: ChangeSortTasksRequest, responseFunc: @escaping ApiResponseProtocol<[TaskResponse]>) 
}
