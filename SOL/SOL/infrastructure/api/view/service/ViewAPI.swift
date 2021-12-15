//
//  ViewAPI.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation


class ViewAPI: RequestService, ViewUserRepositoryPort {
    func myRoot(responseFunc: @escaping ApiResponseProtocol<[ViewUserResponse]>){
        self.requestFormUrl(url: ViewUserRoutes.MY_ROOT, method: "GET", responseFunc: responseFunc)
    }
    
    func findByTask(taskId: String, responseFunc: @escaping ApiResponseProtocol<[TaskInViewResponse]>) {
        self.requestFormUrl(url: ViewUserRoutes.BY_TASK + "?taskId=\(taskId)", method: "GET", responseFunc: responseFunc)
    }
    
    func findByView(viewId: String, responseFunc: @escaping ApiResponseProtocol<[TaskInViewResponse]>) {
        self.requestFormUrl(url: ViewUserRoutes.BY_VIEW + "?viewId=\(viewId)", method: "GET", responseFunc: responseFunc)
    }
           
    func createTaskInView(taskId: String, viewId: String, responseFunc: @escaping ApiResponseProtocol<TaskInViewResponse>) {
        self.requestJson(url: ViewUserRoutes.ROOT, method: "POST", requestBody: CreateTaskInViewRequest(taskId: taskId, viewId: viewId, sortNum: nil), responseFunc: responseFunc)
    }
    
    func deleteTaskInView(taskId: String, viewId: String, responseFunc: @escaping ApiResponseProtocol<Bool>) {
        self.requestFormUrl(url: ViewUserRoutes.ROOT + "?taskId=\(taskId)&viewId=\(viewId)", method: "DELETE", responseFunc: responseFunc)
    }
}
