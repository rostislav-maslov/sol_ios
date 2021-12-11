//
//  SolApiService.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

class SolApiService {
    private static var instance: SolApiService?
    let auth: AuthAPI = AuthAPI()
    let space: SpaceAPI = SpaceAPI()
    let task: TaskAPI = TaskAPI()
    let slot: SlotAPI = SlotAPI()
    let view: ViewAPI = ViewAPI()
    
    static func api() -> SolApiService{
        if( instance == nil) {
            instance = SolApiService()
        }
        
        return instance!
    }
    
}
