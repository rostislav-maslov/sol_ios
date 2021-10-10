//
//  SlotUpdateRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 02.10.2021.
//

import Foundation

public struct SlotUpdateRequest: Codable{
    var endTime: Int64
    var startTime:  Int64
    var id: String
    var timezone: Int
}

