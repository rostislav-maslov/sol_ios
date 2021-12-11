//
//  File.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation

class AuthRoutes {
    static let ROOT = BaseRoutes.NOT_SECURE_V1
    static let SIGN_UP_EMAIL = BaseRoutes.NOT_SECURE_V1 + "/sign-up/email"
    static let ME = BaseRoutes.V1 + "/user/me"
    static let REFRESH_TOKEN = ROOT + "/auth/refresh"
    static let LOGIN = ROOT + "/auth/login/email"
}
