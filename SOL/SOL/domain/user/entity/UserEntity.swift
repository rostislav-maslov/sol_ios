//
//  UserEntity.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation

public class UserEntity {
    var id: String = ""
    var username: String
    
    init(_ id: String, _ username:String){
        self.id = id
        self.username = username
    }
    
}
