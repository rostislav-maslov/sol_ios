//
//  BaseApiErrorResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

struct BaseApiErrorResponse: Codable {
    var errors: [Error] = []
    var status: Int = 0
    var path: String = ""
    var timestamp: String = ""
    var traceId: String = ""
}
