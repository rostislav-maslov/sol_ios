//
//  SlotAPI.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.10.2021.
//

import Foundation

class SlotAPI: RequestService, SlotRepositoryPort {

    func create(_ request: SlotCreateRequest, responseFunc: @escaping ApiResponseProtocol<SlotResponse>) {
        self.requestJson(url: SlotRoutes.ROOT, method: "POST", requestBody: request, responseFunc: responseFunc)
    }
    func edit(_ request: SlotUpdateRequest, responseFunc: @escaping ApiResponseProtocol<SlotResponse>){
        self.requestJson(url: "\(SlotRoutes.ROOT)/\(request.id)", method: "PUT", requestBody: request, responseFunc: responseFunc)
    }
    func findById(_ id: String, responseFunc: @escaping ApiResponseProtocol<SlotResponse>){
        self.requestFormUrl(url: SlotRoutes.ROOT + "/\(id)", method: "GET", responseFunc: responseFunc)
    }
    func delete(_ id: String, responseFunc: @escaping ApiResponseProtocol<SlotResponse>){
        self.requestFormUrl(url: SlotRoutes.ROOT + "/\(id)", method: "DELETE", responseFunc: responseFunc)
    }
    func findByTaskId(_ taskId: String, responseFunc: @escaping ApiResponseProtocol<[SlotResponse]>){
        self.requestFormUrl(url: SlotRoutes.ROOT + "?taskId=\(taskId)", method: "GET", responseFunc: responseFunc)
    }
    func findByDate(_ date: Int64, _ timezone: Int, responseFunc: @escaping ApiResponseProtocol<BaseListResponse<SlotResponse>>){
        self.requestFormUrl(url: SlotRoutes.ROOT + "?date=\(date)&timezone=\(timezone)", method: "GET", responseFunc: responseFunc)
    }
    
    
    
}
