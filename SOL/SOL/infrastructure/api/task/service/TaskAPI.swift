//
//  TaskAPI.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.08.2021.
//

import Foundation

class TaskAPI: RequestService, TaskRepositoryPort {
    
    func create(_ request: TaskCreateRequest, responseFunc: @escaping ApiResponseProtocol<TaskResponse>) {
        self.requestJson(url: TaskRoutes.ROOT, method: "POST", requestBody: request, responseFunc: responseFunc)
    }
    
    func editTitleAndIcon(_ request: EditTitleAndIconTaskRequest, responseFunc: @escaping ApiResponseProtocol<TaskResponse>) {
        self.requestJson(url: TaskRoutes.ROOT + "/\(request.id!)", method: "PATCH", requestBody: request, responseFunc: responseFunc)
    }
    
    func findById(_ id: String, responseFunc: @escaping ApiResponseProtocol<TaskResponse>) {
        self.requestFormUrl(url: TaskRoutes.ROOT + "/\(id)", method: "GET", responseFunc: responseFunc)
    }
    
    func findAll(responseFunc: @escaping ApiResponseProtocol<[TaskResponse]>) {
        self.requestFormUrl(url: TaskRoutes.ROOT, method: "GET", responseFunc: responseFunc)
    }
    
    func makeDone(_ id: String, responseFunc: @escaping ApiResponseProtocol<TaskResponse>) {
        self.requestFormUrl(url: TaskRoutes.ROOT + "/\(id)/done", method: "POST", responseFunc: responseFunc)
    }
    
    func makeOpen(_ id: String, responseFunc: @escaping ApiResponseProtocol<TaskResponse>) {
        self.requestFormUrl(url: TaskRoutes.ROOT + "/\(id)/open", method: "POST", responseFunc: responseFunc)
    }
    
    func changeSort(_ request: ChangeSortTasksRequest, responseFunc: @escaping ApiResponseProtocol<[TaskResponse]>) {
        self.requestJson(url: TaskRoutes.SORT_NUM, method: "POST", requestBody: request, responseFunc: responseFunc)
    }
    
    
}
