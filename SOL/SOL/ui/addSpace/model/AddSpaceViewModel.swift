//
//  AddSpaceViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.08.2021.
//

import Foundation
import Combine

public class AddSpaceViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var state: ViewState = ViewState.NORMAL
    @Published var emoji: String = "🪐"
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space as! SpaceRepositoryPort
    
    func create() -> Void {
        if self.state != .LOADING {
            self.state = .LOADING
            
            SolPublisher<SpaceEntity, Bool>(useCase: CreateSpaceUseCase(self.port, CreateSpaceUseCase.Input.init(title: title, emoji: emoji)))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    if(result.success != nil) {
                        // self?.state = .NORMAL
                        self?.state = .NORMAL
                    } else {
                        self?.state = .ERROR
                    }
                    
                }
                .store(in: &disposables)
        }
    }
}
