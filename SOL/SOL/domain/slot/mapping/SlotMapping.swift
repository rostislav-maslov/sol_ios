//
//  SlotMapping.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.10.2021.
//

import Foundation

public class SlotMapping {
    
    public static func mapping(response: [TaskResponse]) -> [TaskEntity] {
        var spaces: [TaskEntity] = []
        
        for resp:TaskResponse in response {
            spaces.append(mapping(response: resp))
        }
        return spaces
    }
    
    public static func mapping(response: TaskResponse) -> TaskEntity {
        let task: TaskEntity = TaskEntity()
        task.icon = SpaceMapping.mapping(response: response.icon!)
        task.id = response.id!
        task.title = response.title!
                
        task.createdFromRepeatTaskId = response.createdFromRepeatTaskId
        task.deadline = response.deadline != nil ? Date(milliseconds: response.deadline!) : nil
        task.description = response.description!
        task.externalIds = response.externalIds!
        task.files = response.files!
        task.hasChild = response.hasChild == nil ? false : response.hasChild!
        
        task.ownerId = response.ownerId
        task.parentTaskId = response.parentTaskId
        task.pics = response.pics!
        task.planningPoints = response.planningPoints!
        task.pointWeight = response.pointWeight!
        task.repeatTaskConfId = response.repeatTaskConfId
        task.spaceId = response.spaceId
        task.status = response.status
        task.viewIds = response.viewIds!
        
        var child: [TaskEntity] = []
        if response.child != nil {
            child = mapping(response: response.child!)
        }
        task.child = child
        
        task.slots = []
        
        return task
    }
    

}
