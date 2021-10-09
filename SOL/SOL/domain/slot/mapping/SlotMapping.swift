//
//  SlotMapping.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.10.2021.
//

import Foundation

public class SlotMapping {
    
    public static func mapping(response: [SlotResponse]) -> [SlotEntity] {
        var slots: [SlotEntity] = []
        
        for resp:SlotResponse in response {
            slots.append(mapping(response: resp))
        }
        return slots
    }
    
    public static func mapping(response: SlotResponse) -> SlotEntity {
        let slot: SlotEntity = SlotEntity()
        slot.id =  response.id!
        slot.startTime =  response.startTime != nil ? Date(milliseconds: response.startTime!) : nil
        slot.endTime =  response.endTime != nil ? Date(milliseconds: response.endTime!) : nil
        slot.title =  response.title ?? ""
        slot.ownerId =  response.ownerId
        slot.createdFromTaskId =  response.createdFromTaskId
        slot.spaceId =  response.spaceId
        slot.viewIds =  response.viewIds
        slot.slotsMilliseconds =  response.slotsMilliseconds
        slot.externalIds =  response.externalIds
        slot.timezone =  response.timezone
        slot.createdAt =  response.createdAt
        slot.updatedAt =  response.updatedAt
        
        return slot
    }
    

}
