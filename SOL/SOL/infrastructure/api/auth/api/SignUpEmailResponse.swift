//
//  SignUpEmailResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

struct SignUpEmailResponse: Codable {
    var id: String
    var username: String 
    var accessToken: String
    var refreshToken: String
}
