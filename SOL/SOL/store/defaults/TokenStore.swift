//
//  TokenStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation

class TokenStore {
     func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: UD_ACCESS_TOKEN)
    }
    
     func setAccessToken(_ token: String?) -> Void {
        UserDefaults.standard.setValue(token, forKey: UD_ACCESS_TOKEN)
    }
    
     func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: UD_REFRESH_TOKEN)
    }
    
     func setRefreshToken(_ token: String?) -> Void {
        UserDefaults.standard.setValue(token, forKey: UD_REFRESH_TOKEN)
    }
  
}
