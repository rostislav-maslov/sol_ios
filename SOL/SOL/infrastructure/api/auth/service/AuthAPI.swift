//
//  AuthService.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation


class AuthAPI: RequestService, UserRepositoryPort {    
    
    func signUp(_ request: SignUpEmailRequest, responseFunc: @escaping ApiResponseProtocol<SignUpEmailResponse>) {
        self.requestJson(url: AuthRoutes.SIGN_UP_EMAIL, method: "POST", request: request, responseFunc: responseFunc)
    }
    
    func refreshToken(_ request: RefreshTokenRequest, responseFunc: @escaping ApiResponseProtocol<SignUpEmailResponse>) {
        self.requestJson(url: AuthRoutes.REFRESH_TOKEN, method: "POST", request: request, responseFunc: responseFunc)
    }
    
}
