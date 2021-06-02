//
//  BaseRoutes.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

class BaseRoutes {
    static let HOST: String = "https://sol-api.maslov.tech"
    // static let HOST: String = "http://sol.localhost:9095"
    
    private static let API:String = "/api"
    
    static let NOT_SECURE_V1 = HOST + "/not-secure" + API + "/v1"
    static let V1 = HOST + API + "/v1"
}
