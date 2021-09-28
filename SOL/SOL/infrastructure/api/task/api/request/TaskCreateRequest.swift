//
//  TaskCreateRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.08.2021.
//

import Foundation


public struct TaskCreateRequest: Codable {
    var icon:IconResponse?
    var parentTaskId:String?
    var spaceId: String?
    var title: String?
    @NullEncodable var deadline: Int64?
    @NullEncodable var deadlineType: String?
    @NullEncodable var timezone: Int?
}
