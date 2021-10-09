//
//  SlotCreateRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.10.2021.
//

import Foundation

public struct SlotCreateRequest: Codable{
    var endTime: Int64
    var startTime:  Int64
    var taskId: String
    var timezone: Int
}



