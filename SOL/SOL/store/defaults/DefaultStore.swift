//
//  UserDefaultService.swift
//  SOL
//
//  Created by Rostislav Maslov on 30.05.2021.
//

import Foundation

let UD_ACCESS_TOKEN: String = "UD_ACCESS_TOKEN"
let UD_REFRESH_TOKEN: String = "UD_REFRESH_TOKEN"
let UD_SOL_USER_ID: String = "UD_SOL_USER_ID"

class DefaultStore{
    
    let token:TokenStore = TokenStore()
    let user: UserStore = UserStore()
    
    static let store:DefaultStore = DefaultStore()
    
}
