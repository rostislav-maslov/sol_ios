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

class LocalStorage{
    
    static func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: UD_ACCESS_TOKEN)
    }
    
    static func setAccessToken(_ token: String?) -> Void {
        UserDefaults.standard.setValue(token, forKey: UD_ACCESS_TOKEN)
    }
    
    static func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: UD_REFRESH_TOKEN)
    }
    
    static func setRefreshToken(_ token: String?) -> Void {
        UserDefaults.standard.setValue(token, forKey: UD_REFRESH_TOKEN)
    }
    
    static func getUserId() -> String? {
        return UserDefaults.standard.string(forKey: UD_SOL_USER_ID)
    }
    
    static func setUserId(_ id: String?) -> Void {
        UserDefaults.standard.setValue(id, forKey: UD_SOL_USER_ID)
    }
    
}
