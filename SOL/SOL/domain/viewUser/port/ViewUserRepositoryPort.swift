//
//  ViewUserRepositoryPort.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation

protocol ViewUserRepositoryPort{    
    func myRoot(responseFunc: @escaping ApiResponseProtocol<[ViewUserResponse]>)
    func findByTask(taskId: String, responseFunc: @escaping ApiResponseProtocol<[TaskInViewResponse]>)
    func findByView(viewId: String, responseFunc: @escaping ApiResponseProtocol<[TaskInViewResponse]>)
    func createTaskInView(taskId: String, viewId: String, responseFunc: @escaping ApiResponseProtocol<TaskInViewResponse>)
    func deleteTaskInView(taskId: String, viewId: String, responseFunc: @escaping ApiResponseProtocol<Bool>)
}
