//
//  SlotResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.10.2021.
//

import Foundation


public struct SlotResponse: Codable{
    var id: String?
    var startDate: Date?
    var endDate: Date?
    var title: String?
    var ownerId: String?
    var createdFromTaskId: String?
    var spaceId: String?
    var viewIds: [String] = []
    var slotsMilliseconds: Int64 = 0
    var externalIds: [String] = []
    var timezone: Int = 0
    var createdAt: Date?
    var updatedAt: Date?
}
