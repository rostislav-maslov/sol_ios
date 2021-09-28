//
//  TaskResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.08.2021.
//

import Foundation
 
public struct TaskResponse: Codable{
    var id: String?    
    var createdFromRepeatTaskId: String?
    var deadline: Int64?
    var description: String?
    var externalIds:[String]?
    var files:[String]?
    var hasChild:Bool?
    var icon:IconResponse?
    var ownerId:String?
    var parentTaskId:String?
    var pics:[String]?
    var planningPoints:[String]?
    var pointWeight:Int?
    var repeatTaskConfId:String?
    var spaceId:String?
    var status:TaskStatus = TaskStatus.OPEN
    var title:String?
    var viewIds:[String]?
    var child:[TaskResponse]?
}
