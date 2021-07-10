//
//  SpaceProvider.swift
//  SOL
//
//  Created by Rostislav Maslov on 01.06.2021.
//

import Foundation

class SpaceProvider {
    var spaces: [SpaceResponse] = []
        

    func updateSpaces() -> Void {
        SolApiService.api().space.mySpaces { (response: BaseApiResponse<[SpaceResponse]>?, error: BaseApiErrorResponse?, success: Bool) in
            if success == true && response != nil {
                self.spaces = response!.result
//                self.updated()
            }
        }
    }
    
    func create(title: String, icon: String,  callback: @escaping (() -> Void)) -> Void {
        if title == "" {return}
        
        let emoji:String = icon != "" ? icon : "🪐"
        
        let spaceRequest: SpaceCreateRequest = SpaceCreateRequest(title: title, icon: emoji)
        SolApiService.api().space.create(spaceRequest, responseFunc: { (response: BaseApiResponse<SpaceResponse>?, errorResponse: BaseApiErrorResponse?, success:Bool) in
//            self.updated()
            callback()
        })
    }
    
    
}
