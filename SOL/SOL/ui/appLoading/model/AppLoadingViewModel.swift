//
//  AppLoadingViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation
import Combine

class AppLoadingViewModel: NSObject, ObservableObject {
    @Published var goToLogin = false
    @Published var goToSpaces = false
    @Published var id = UUID()

    private var disposables = Set<AnyCancellable>()    
    private let port:UserRepositoryPort = SolApiService.api().auth
    
    func refresh(callback: @escaping (_ res: Bool) -> Void){
        SolPublisher<AuthState, Bool>(useCase: WarmUpUseCase(port: self.port))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                if(status.success == AuthState.UNLOGGED) {
                    //self?.goToLogin = true
                    //self?.goToSpaces = false
                    callback(false)
                }
                
                if(status.success == AuthState.LOGGED) {
                    //self?.goToLogin = false
                    //self?.goToSpaces = true
                    callback(true)
                }
                //self?.id = UUID()
            }
            .store(in: &disposables)

    }
    
}
