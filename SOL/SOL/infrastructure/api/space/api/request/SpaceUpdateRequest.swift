//
//  SpaceUpdateRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 06.08.2021.
//

import Foundation

public struct SpaceUpdateRequest: Codable  {
     var id: String?
     var title: String?
     var icon: String?
    
    public static func of(_ id: String,_  title: String,_  icon: String) -> SpaceUpdateRequest {
        var req: SpaceUpdateRequest = SpaceUpdateRequest()
        req.id = id
        req.title = title
        req.icon = icon
        return req
    }
}
