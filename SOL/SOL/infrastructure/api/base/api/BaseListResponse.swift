//
//  BaseListResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.10.2021.
//

import Foundation

struct BaseListResponse<T: Codable>: Codable {
    var count: Int
    var items:[T]
}
