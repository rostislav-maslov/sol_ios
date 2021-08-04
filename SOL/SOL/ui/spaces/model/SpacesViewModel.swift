//
//  SpacesViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation
import Combine

public class SpacesViewModel: ObservableObject {
    @Published var goToLogout: Bool = false
    @Published var showAddSpaceSheet: Bool = false
    @Published var spaces: [SpaceEntity] = []
    @Published var state: ViewState = ViewState.INITIALIZATION
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
}

extension SpacesViewModel{
    public func onAddSpacesTouch () -> Void {
        showAddSpaceSheet = true
    }
    
    public func onDissmisAddSpace () -> Void {
        showAddSpaceSheet = false
    }
}

extension SpacesViewModel{
    func load(){
        self.state = ViewState.LOADING
        SolPublisher<[SpaceEntity], Bool>(useCase: MySpacesUseCase(self.port))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    self?.spaces = publisherReponse.success!
                }else {
                    self?.state = ViewState.ERROR
                    self?.spaces = []
                }
                
                
            }
            .store(in: &disposables)

    }       
}
