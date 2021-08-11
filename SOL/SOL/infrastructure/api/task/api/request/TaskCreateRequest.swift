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
}
