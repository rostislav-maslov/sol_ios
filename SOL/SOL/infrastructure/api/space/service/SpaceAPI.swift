//
//  SpaceService.swift
//  SOL
//
//  Created by Rostislav Maslov on 01.06.2021.
//

import Foundation

class SpaceAPI: RequestService, SpaceRepositoryPort {
    
    func create(_ request: SpaceCreateRequest, responseFunc: @escaping ApiResponseProtocol<SpaceResponse>) {
        self.requestJson(url: SpaceRoutes.ROOT, method: "POST", requestBody: request, responseFunc: responseFunc)
    }
    
    func mySpaces(_ responseFunc: @escaping ApiResponseProtocol<[SpaceResponse]>) {
        self.requestFormUrl(url: SpaceRoutes.ROOT, method: "GET", responseFunc: responseFunc)
    }
    
}