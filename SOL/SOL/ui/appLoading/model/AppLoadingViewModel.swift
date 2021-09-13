//
//  AppLoadingViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation
import Combine

public enum AppLoadingState {
    case INIT
    case LOGIN
    case SPACES
}

class AppLoadingViewModel: NSObject, ObservableObject {
    @Published var id = UUID()

    private var disposables = Set<AnyCancellable>()    
    private let port:UserRepositoryPort = SolApiService.api().auth
    
    func refresh(callback: @escaping (_ res: AppLoadingState) -> Void){
        SolPublisher<AuthState, Bool>(useCase: WarmUpUseCase(port: self.port))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                if(status.success == AuthState.UNLOGGED) {
                    //self?.goToLogin = true
                    //self?.goToSpaces = false
                    callback(AppLoadingState.LOGIN)
                }
                
                if(status.success == AuthState.LOGGED) {
                    //self?.goToLogin = false
                    //self?.goToSpaces = true
                    callback(AppLoadingState.SPACES)
                }
                //self?.id = UUID()
            }
            .store(in: &disposables)

    }
    
}
