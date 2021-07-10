//
//  SpaceService.swift
//  SOL
//
//  Created by Rostislav Maslov on 01.06.2021.
//

import Foundation

class SpaceService: RequestService {    
    
    func create(_ request: SpaceCreateRequest, responseFunc: @escaping ApiResponseProtocol<SpaceResponse>) {
        self.requestJson(url: SpaceRoutes.ROOT, method: "POST", request: request, responseFunc: responseFunc)
    }
    
    func mySpaces(_ responseFunc: @escaping ApiResponseProtocol<[SpaceResponse]>) {
        self.requestFormUrl(url: SpaceRoutes.ROOT, method: "GET", responseFunc: responseFunc)
    }
    
}
