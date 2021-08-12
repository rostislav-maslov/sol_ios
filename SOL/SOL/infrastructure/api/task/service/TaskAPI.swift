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
    
    func findById(_ id: String, responseFunc: @escaping ApiResponseProtocol<TaskResponse>) {
        self.requestFormUrl(url: TaskRoutes.ROOT + "/\(id)", method: "GET", responseFunc: responseFunc)
    }
    
    
}
