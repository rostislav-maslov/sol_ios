//
//  UserStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation

class UserStore {
    
     func getUserId() -> String? {
        return UserDefaults.standard.string(forKey: UD_SOL_USER_ID)
    }
    
     func setUserId(_ id: String?) -> Void {
        UserDefaults.standard.setValue(id, forKey: UD_SOL_USER_ID)
    }
}
