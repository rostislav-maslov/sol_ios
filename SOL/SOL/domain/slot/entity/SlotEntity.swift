//
//  SlotEntity.swift
//  SOL
//
//  Created by Rostislav Maslov on 13.07.2021.
//

import Foundation
import CalendarKit

public class SlotEntity {
    var id: String = UUID().uuidString
    var startTime: Date?
    var endTime: Date?
    var title: String = ""
    var ownerId: String?
    var createdFromTaskId: String?
    var spaceId: String?
    var viewIds: [String] = []
    var slotsMilliseconds: Int64 = 0
    var externalIds: [String] = []
    var timezone: Int = 0
    var createdAt: Date?
    var updatedAt: Date?
    
    var isDraft: Bool = false
    
    var eventDescriptor:Event = Event()
    
    

}

extension SlotEntity {
    var dayInfo: String {
        return "четверг, 21 окт 2021г"
    }
    var timeInfo: String {
        return "c 9:00 до 18:00"
    }
    func updateAndReturnDescriptor() -> EventDescriptor {
        eventDescriptor.dateInterval.start = startTime!
        
        // Это нужно, что бы события не накладывались друг на друга
        if Calendar.current.component(.minute, from: endTime!) % 5 == 0 {
            eventDescriptor.dateInterval.end = Calendar.current.date(byAdding: .minute, value: -2, to: endTime!)!
        }else{
            eventDescriptor.dateInterval.end = endTime!
        }
        
        
        eventDescriptor.userInfo = id
        eventDescriptor.isAllDay = false
        //var info = ""// TODO data[Int(arc4random_uniform(UInt32(data.count)))]
        
        //info.append(rangeFormatter.string(from: event.startDate, to: event.endDate))
        eventDescriptor.text = title
        if isDraft {
            //event.color = UIColor.red
            eventDescriptor.color = UIColor(SolColor.colors().fontColors.normal)
        }else{
            eventDescriptor.color = UIColor(SolColor.colors().fontColors.second)
        }
        
        return eventDescriptor
    }
}
