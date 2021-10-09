//
//  SlotEntity.swift
//  SOL
//
//  Created by Rostislav Maslov on 13.07.2021.
//

import Foundation

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
}
