//
//  WarmUpUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation


public class WarmUpUseCase: UseCase<AuthState, Bool>{
    let port: UserRepositoryPort!
    
    init(port: UserRepositoryPort) {
        self.port = port
    }
    
    override public func execute(_ callback: @escaping (AuthState?, Bool?) -> Void) {
        let userId: String? = DefaultStore.store.user.getUserId()
        let accessToken: String? = DefaultStore.store.token.getAccessToken()
        let refreshToken: String? = DefaultStore.store.token.getRefreshToken()
        
        if (userId == nil) {
            DefaultStore.store.user.setUserId(nil)
            DefaultStore.store.token.setRefreshToken(nil)
            DefaultStore.store.token.setAccessToken(nil)
            callback(AuthState.UNLOGGED, true)
            return
        }
        if( accessToken == nil || refreshToken == nil ) {
            callback(AuthState.UNLOGGED, true)
            return
        }
        
        let request: RefreshTokenRequest = RefreshTokenRequest(refreshToken: refreshToken!)
        
        self.port.refreshToken(request) {  (response: BaseApiResponse<RefreshTokenResponse>?, errorResponse: BaseApiErrorResponse?, success: Bool) in
            if response != nil {
                DefaultStore.store.token.setAccessToken(response!.result.accessToken)
                DefaultStore.store.token.setRefreshToken(response!.result.refreshToken)
                
                self.port.me { (success:BaseApiResponse<MeResponse>?, error: BaseApiErrorResponse?, isSuccess: Bool) in
                    if success != nil {
                        DefaultStore.store.user.setUserId(success!.result.id)
                        callback(AuthState.LOGGED, true)
                    }
                    if isSuccess == false || errorResponse != nil {
                        callback(AuthState.UNLOGGED, true)
                    }
                }
            }
            if success == false || errorResponse != nil {
                callback(AuthState.UNLOGGED, true)
            }
        }
    }
}
