//
//  CreateTaskInViewRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.12.2021.
//

import Foundation

public struct CreateTaskInViewRequest: Codable{
    var taskId: String?
    var viewId: String?
    var sortNum: Int?
}
