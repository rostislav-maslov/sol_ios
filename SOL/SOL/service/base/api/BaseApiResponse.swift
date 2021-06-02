//
//  BaseApiResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

struct BaseApiResponse<T: Codable>: Codable {
    var result:T
}
