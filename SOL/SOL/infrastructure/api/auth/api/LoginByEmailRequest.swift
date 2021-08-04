//
//  LoginByEmailRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.08.2021.
//

import Foundation

struct LoginByEmailRequest: Codable {
    var email:String?
    var password:String?
}
