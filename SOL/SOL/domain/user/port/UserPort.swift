//
//  WarmUpUseCasePort.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation

protocol UserRepositoryPort{
    func refreshToken(_ request: RefreshTokenRequest, responseFunc: @escaping ApiResponseProtocol<RefreshTokenResponse>)
    func signUp(_ request: SignUpEmailRequest, responseFunc: @escaping ApiResponseProtocol<SignUpEmailResponse>)
    func loginByEmail(_ request: LoginByEmailRequest, responseFunc: @escaping ApiResponseProtocol<LoginByEmailResponse>)
    func me(responseFunc: @escaping ApiResponseProtocol<MeResponse>)
}
