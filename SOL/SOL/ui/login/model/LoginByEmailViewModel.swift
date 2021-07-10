//
//  LoginByEmailViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.07.2021.
//

import Foundation
import Combine

class LoginByEmailViewModel: ObservableObject {
    @Published var state: ViewState = .NORMAL
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var navigateToSpace: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    private let port:UserRepositoryPort = SolApiService.api().auth
    
    func signUp() -> Void {
        if self.state != .LOADING {
            self.state = .LOADING
            
            SolPublisher<UserEntity, Bool>(useCase: SignUpByEmailUseCase(self.port, SignUpByEmailUseCase.Input.init(email: email, password: password)))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    if(result.success != nil) {
                        // self?.state = .NORMAL
                        self?.navigateToSpace = true
                    } else {
                        self?.state = .ERROR
                        self?.navigateToSpace = false
                    }
                    
                }
                .store(in: &disposables)
        }
    }
    
    
}
