//
//  AppLoadingViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.07.2021.
//

import Foundation
import Combine

class AppLoadingViewModel: ObservableObject, Identifiable {
    @Published var goToLogin = false
    @Published var goToSpaces = false

    private var disposables = Set<AnyCancellable>()    
    private let warmUpPort:WarmUpUseCasePort = SolApiService.api().auth
    
    func refresh(){
        SolPublisher<AuthState, Bool>(useCase: WarmUpUseCase(port: self.warmUpPort))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                if(status.success == AuthState.UNLOGGED) {
                    self?.goToLogin = true
                    self?.goToSpaces = false
                }
                
                if(status.success == AuthState.LOGGED) {
                    self?.goToLogin = false
                    self?.goToSpaces = true
                }
            }
            .store(in: &disposables)

    }
    
}
