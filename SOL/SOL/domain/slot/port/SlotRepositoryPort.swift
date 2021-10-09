//
//  SlotRepositoryPort.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.10.2021.
//

import Foundation

protocol SlotRepositoryPort{
    func create(_ request: SlotCreateRequest, responseFunc: @escaping ApiResponseProtocol<SlotResponse>)
    func edit(_ request: SlotUpdateRequest, responseFunc: @escaping ApiResponseProtocol<SlotResponse>)
    func findById(_ id: String, responseFunc: @escaping ApiResponseProtocol<SlotResponse>)
    func delete(_ id: String, responseFunc: @escaping ApiResponseProtocol<SlotResponse>)
    func findByTaskId(_ taskId: String, responseFunc: @escaping ApiResponseProtocol<[SlotResponse]>)
    func findByDate(_ date: Int64, _ timezone: Int, responseFunc: @escaping ApiResponseProtocol<BaseListResponse<SlotResponse>>)
}
