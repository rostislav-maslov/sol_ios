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
    
    var spaceStore: SpaceStore?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space 
    
    func create() -> Void {
        if self.state != .LOADING {
            self.state = .LOADING
            
            SolPublisher<SpaceEntity, Bool>(useCase: CreateSpaceUseCase(self.port, CreateSpaceUseCase.Input.init(title: title, emoji: emoji)))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    if(result.success != nil) {                        
                        self?.state = .NORMAL
                        self?.spaceStore?.sync()
                    } else {
                        self?.state = .ERROR
                    }                    
                }
                .store(in: &disposables)
        }
    }
}
