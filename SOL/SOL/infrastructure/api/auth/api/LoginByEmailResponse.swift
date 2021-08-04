//
//  LoginByEmailResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.08.2021.
//

import Foundation

struct LoginByEmailResponse: Codable {
    var accessToken:String?
    var refreshToken:String?
}
