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
    @Published var state: ViewState = ViewState.INITIALIZATION
    @Published var defaultTaskAddTitle = "in Inbox"
    @Published var isTarget = true
    
    var store: SpaceStore?
    
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

