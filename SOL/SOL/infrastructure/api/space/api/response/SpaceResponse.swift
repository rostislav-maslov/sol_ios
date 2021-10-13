//
//  SpaceResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 01.06.2021.
//

import Foundation

public struct SpaceResponse: Codable  {
    var id:String
    var title:String
    var icon:IconResponse
    var sortNum:Int
    var countTask: Int = 0
    var tasks:[TaskResponse]?
    
}
