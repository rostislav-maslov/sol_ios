//
//  WarmUpUseCasePort.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation

protocol UserRepositoryPort{
    func refreshToken(_ request: RefreshTokenRequest, responseFunc: @escaping ApiResponseProtocol<SignUpEmailResponse>)
    func signUp(_ request: SignUpEmailRequest, responseFunc: @escaping ApiResponseProtocol<SignUpEmailResponse>)
}
