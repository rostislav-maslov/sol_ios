//
//  SpaceMapping.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.08.2021.
//

import Foundation

public class SpaceMapping {
    
    public static func mapping(response: [SpaceResponse]) -> [SpaceEntity] {
        var spaces: [SpaceEntity] = []
        
        for resp:SpaceResponse in response {
            spaces.append(mapping(response: resp))
        }        
        return spaces
    }
    
    public static func mapping(response: SpaceResponse) -> SpaceEntity {
        let space: SpaceEntity = SpaceEntity()
        space.icon = SpaceMapping.mapping(response: response.icon)
        space.id = response.id
        space.sortNum = response.sortNum
        space.title = response.title
        space.countTask = response.countTask
        if response.tasks != nil {
            space.tasks = TaskMapping.mapping(response: response.tasks!)
        }else{
            space.tasks = []
        }
        
        return space
    }
    
    public static func mapping(response: IconResponse) -> IconEntity {
        let icon: IconEntity = IconEntity()
        icon.data = response.data!
        icon.type = response.type
        return icon
    }
}
