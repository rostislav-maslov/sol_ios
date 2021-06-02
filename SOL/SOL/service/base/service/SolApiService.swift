//
//  SolApiService.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

class SolApiService {
    static var instance: SolApiService?
    let auth: AuthService = AuthService()
    let space: SpaceService = SpaceService()
    
    static func api() -> SolApiService{
        if( instance == nil) {
            instance = SolApiService()
        }
        
        return instance!
    }
    
}
