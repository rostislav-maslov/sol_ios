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
    
    func viewAll(responseFunc: @escaping ApiResponseProtocol<[ViewUserResponse]>){
        self.requestFormUrl(url: ViewUserRoutes.ALL, method: "GET", responseFunc: responseFunc)
    }
    
    func findByTask(taskId: String, responseFunc: @escaping ApiResponseProtocol<[TaskInViewResponse]>) {
        self.requestFormUrl(url: ViewUserRoutes.BY_TASK + "?taskId=\(taskId)", method: "GET", responseFunc: responseFunc)
    }
    
    func findByView(viewId: String, responseFunc: @escaping ApiResponseProtocol<[TaskInViewResponse]>) {
        self.requestFormUrl(url: ViewUserRoutes.BY_VIEW + "?viewId=\(viewId)", method: "GET", responseFunc: responseFunc)
    }
           
    func createTaskInView(taskId: String, viewId: String, responseFunc: @escaping ApiResponseProtocol<TaskInViewResponse>) {
        self.requestJson(url: ViewUserRoutes.ADD_TASK, method: "POST", requestBody: CreateTaskInViewRequest(taskId: taskId, viewId: viewId, sortNum: nil), responseFunc: responseFunc)
    }
    
    func deleteTaskInView(taskId: String, viewId: String, responseFunc: @escaping ApiResponseProtocol<Bool>) {
        self.requestFormUrl(url: ViewUserRoutes.ROOT + "?taskId=\(taskId)&viewId=\(viewId)", method: "DELETE", responseFunc: responseFunc)
    }
    
    func deleteViewUser(viewId: String, responseFunc: @escaping ApiResponseProtocol<Bool>) {
        self.requestFormUrl(url: ViewUserRoutes.ROOT + "/\(viewId)", method: "DELETE", responseFunc: responseFunc)
    }
    
    func createView(request: CreateViewUserRequest, responseFunc: @escaping ApiResponseProtocol<ViewUserResponse>) {
        self.requestJson(url: ViewUserRoutes.ROOT, method: "POST", requestBody: request, responseFunc: responseFunc)        
    }
    
    func updateView(viewId: String, request: CreateViewUserRequest, responseFunc: @escaping ApiResponseProtocol<ViewUserResponse>) {
        self.requestJson(url: ViewUserRoutes.ROOT + "/" + viewId + "/update-full", method: "PATCH", requestBody: request, responseFunc: responseFunc)
    }
    
    func hide(viewId: String, responseFunc: @escaping ApiResponseProtocol<Bool>){
        self.requestJson(url: ViewUserRoutes.ROOT + "/" + viewId + "/hide", method: "POST", requestBody: "", responseFunc: responseFunc)
    }
    
    func show(viewId: String, responseFunc: @escaping ApiResponseProtocol<Bool>){
        self.requestJson(url: ViewUserRoutes.ROOT + "/" + viewId + "/show", method: "POST", requestBody: "", responseFunc: responseFunc)
    }
    
    func reorder(viewsId: [String], responseFunc: @escaping ApiResponseProtocol<Bool>){
        self.requestJson(url: ViewUserRoutes.ROOT + "/sort-change", method: "POST", requestBody: ChangeSortRequest(views: viewsId), responseFunc: responseFunc)
    }
}
