//
//  AuthService.swift
//  SOL
//
//  Created by Rostislav Maslov on 26.05.2021.
//

import Foundation


class AuthAPI: RequestService, UserRepositoryPort {
    
    func signUp(_ request: SignUpEmailRequest, responseFunc: @escaping ApiResponseProtocol<SignUpEmailResponse>) {
        self.requestJson(url: AuthRoutes.SIGN_UP_EMAIL, method: "POST", requestBody: request, responseFunc: responseFunc)
    }
    
    func loginByEmail(_ request: LoginByEmailRequest, responseFunc: @escaping ApiResponseProtocol<LoginByEmailResponse>) {
        self.requestJson(url: AuthRoutes.LOGIN, method: "POST", requestBody: request, responseFunc: responseFunc)
    }
    
    func refreshToken(_ request: RefreshTokenRequest, responseFunc: @escaping ApiResponseProtocol<RefreshTokenResponse>) {
        self.requestJson(url: AuthRoutes.REFRESH_TOKEN, method: "POST", requestBody: request, responseFunc: responseFunc)
    }
    
    func me(responseFunc: @escaping ApiResponseProtocol<MeResponse>) {
        self.requestJson(url: AuthRoutes.ME, method: "GET", requestBody: EmptyRequest(), responseFunc: responseFunc)
    }
    
}
