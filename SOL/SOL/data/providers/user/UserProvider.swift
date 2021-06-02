//
//  AuthProvider.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.05.2021.
//

import Foundation


class UserProvider: ISolDataProvider {
    var solUser: SolUserEntity?
    var state: AuthState = AuthState.UNLOGGED
    
    override init(updated: @escaping FuncUpdated) {
        super.init(updated:updated)
    }

    func signUp(email: String, password: String, error: (() -> Void)?) -> Void {
        let signUp: SignUpEmailRequest = SignUpEmailRequest(email: email, password: password)
        SolApiService.api().auth.signUp(signUp) {  (response: BaseApiResponse<SignUpEmailResponse>?, errorResponse: BaseApiErrorResponse?, success: Bool) in
            if response != nil {
                self.solUser = SolUserEntity(id: response!.result.id, username: response!.result.username)
                
                LocalStorage.setAccessToken(response!.result.accessToken)
                LocalStorage.setRefreshToken(response!.result.refreshToken)
                LocalStorage.setUserId(response!.result.id)
                
                self.state = .LOGGED
                self.updated()
                //self.login(email: email, password: password)
            }
            
            if errorResponse != nil {
                self.solUser = nil
                self.state = .UNLOGGED
                self.updated()
            }
            
        }
    }
    
    func me() -> Void {
         
    }
    
    func logout(callback: () -> Void) -> Void {
        LocalStorage.setUserId(nil)
        LocalStorage.setRefreshToken(nil)
        LocalStorage.setAccessToken(nil)
        self.state = AuthState.UNLOGGED
        self.solUser = nil
        self.updated()
        callback()
        return
    }
    
    func warmUp(callback: @escaping ((_ status: AuthState) -> Void)) -> Void {
        let userId: String? = LocalStorage.getUserId()
        let accessToken: String? = LocalStorage.getAccessToken()
        let refreshToken: String? = LocalStorage.getRefreshToken()
        
        if (userId == nil) {
            LocalStorage.setUserId(nil)
            LocalStorage.setRefreshToken(nil)
            LocalStorage.setAccessToken(nil)
            callback(AuthState.UNLOGGED)
            return
        }
        
        if( accessToken == nil || refreshToken == nil ) {
            callback(AuthState.UNLOGGED)
            return
        }
        
        let request: RefreshTokenRequest = RefreshTokenRequest(refreshToken: refreshToken!)
        
        SolApiService.api().auth.refreshToken(request) {  (response: BaseApiResponse<SignUpEmailResponse>?, errorResponse: BaseApiErrorResponse?, success: Bool) in
            if response != nil {
                self.solUser = SolUserEntity(id: response!.result.id, username: response!.result.username)
                
                LocalStorage.setAccessToken(response!.result.accessToken)
                LocalStorage.setRefreshToken(response!.result.refreshToken)
                LocalStorage.setUserId(response!.result.id)
                
                self.state = .LOGGED
                self.updated()
                callback(self.state)
                //self.login(email: email, password: password)
            }
            
            if errorResponse != nil {
                self.solUser = nil
                self.state = .UNLOGGED
                self.updated()
                callback(self.state)
            }
            
        }
        
        
    }
    
    
    
//    func login(email: String, password: String) -> Void {
//        let signUp: SignUpEmailRequest = SignUpEmailRequest(email: email, password: password)
////        SolApiService.api().auth.signUp(signUp) {  (response: BaseApiResponse<SignUpEmailResponse>?, errorResponse: BaseApiErrorResponse?, success: Bool) in
////            if success == true {
////                self.logged = true
////            }else {
////                self.logged = false
////            }
////            // тут заполнения токена сделать
////            self.updated()
////        }
//    }
    
}
