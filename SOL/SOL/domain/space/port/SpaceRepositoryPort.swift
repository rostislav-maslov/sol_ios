//
//  SpaceRepositoryPort.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.08.2021.
//

import Foundation

protocol SpaceRepositoryPort{
    func create(_ request: SpaceCreateRequest, responseFunc: @escaping ApiResponseProtocol<SpaceResponse>)    
    func updateTitleIcon(_ request: SpaceUpdateRequest, _ responseFunc: @escaping ApiResponseProtocol<SpaceResponse>) 
    func mySpaces(_ responseFunc: @escaping ApiResponseProtocol<[SpaceResponse]>)
    func space(_ spaceId: String, _ responseFunc: @escaping ApiResponseProtocol<SpaceResponse>)
}
