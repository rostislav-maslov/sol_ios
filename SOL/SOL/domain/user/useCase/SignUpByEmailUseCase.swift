//
//  SignUpByEmailUseCase.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation

public class SignUpByEmailUseCase: UseCase<UserEntity, Bool>{
    let port: UserRepositoryPort!
    private let input: Input
    
    init(_ port: UserRepositoryPort, _ input:Input) {
        self.port = port
        self.input = input
    }
    
    override public func execute(_ callback: @escaping (UserEntity?, Bool?) -> Void) {
        var request:SignUpEmailRequest = SignUpEmailRequest()
        request.email = input.email
        request.password = input.password
        
        //NOTE: - sign up first
        port.signUp(request) { (response:BaseApiResponse<SignUpEmailResponse>?, errorResponse:BaseApiErrorResponse?, success:Bool) in
            if response != nil {
                let user = UserEntity(
                 response!.result.id,
                 response!.result.username)
                
                let loginRequest: LoginByEmailRequest = LoginByEmailRequest(email: self.input.email, password: self.input.password)
                //NOTE: Make reqeust for access token
                self.port.loginByEmail(loginRequest) { (success:BaseApiResponse<LoginByEmailResponse>?, error:BaseApiErrorResponse?, isSuccess:Bool) in
                    if success != nil && isSuccess == true {
                        DefaultStore.store.token.setAccessToken(success!.result.accessToken)
                        DefaultStore.store.token.setRefreshToken(success!.result.refreshToken)
                        DefaultStore.store.user.setUserId(response!.result.id)
                        callback(user, true)
                    }else {
                        DefaultStore.store.token.setAccessToken(nil)
                        DefaultStore.store.token.setRefreshToken(nil)
                        DefaultStore.store.user.setUserId(nil)
                        callback(user, false)
                    }
                }
            }
            
            if errorResponse != nil {
                callback(nil, false)
            }
        }
                
    }
}

extension SignUpByEmailUseCase{
    
    public struct Input{
        var email:String?
        var password:String?
        
        public static func of(_ email:String, _ password: String) -> Input{
            var input:Input = Input()
            input.email = email
            input.password = password
            
            return input
        }
    }
    
}
