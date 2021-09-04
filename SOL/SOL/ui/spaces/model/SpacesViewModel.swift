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

extension SpacesViewModel {
    func reorderSpaces(draggetSpaceId: String, dropOnSpaceId: String) -> Bool{
        if (draggetSpaceId == dropOnSpaceId) {
            return false
        }
        
        var draggetSpaceIndex: Int? = nil
        for index in 0...(spaces.count - 1) {
            if (spaces[index].id == draggetSpaceId) {
                draggetSpaceIndex = index
            }
        }
        if draggetSpaceIndex == nil  {
            return false
        }
        let space = spaces.remove(at: draggetSpaceIndex!)
        
        var dropOnSpaceIndex: Int? = nil
        for index in 0...(spaces.count - 1) {
            if (spaces[index].id == dropOnSpaceId) {
                dropOnSpaceIndex = index
            }
        }
        if  dropOnSpaceIndex == nil {
            return false
        }
        
        spaces.insert(space, at: dropOnSpaceIndex!)
        commitNewSort()
        return true
    }
    
    func moveSpaceToEnd(draggetSpaceId: String) -> Bool{
        if (draggetSpaceId == spaces[spaces.count - 1].id) {
            return false
        }
        
        var draggetSpaceIndex: Int? = nil
        for index in 0...(spaces.count - 1) {
            if (spaces[index].id == draggetSpaceId) {
                draggetSpaceIndex = index
            }
        }
        if draggetSpaceIndex == nil  {
            return false
        }
        let space = spaces.remove(at: draggetSpaceIndex!)
        spaces.insert(space, at: spaces.endIndex)
        commitNewSort()
        return true
    }
    
    func commitNewSort(){
        var spaces:[String] = []
        
        for space in self.spaces {
            spaces.append(space.id)
        }
        
        SolPublisher<[SpaceEntity], Bool>(useCase: ChangeSpaceSortUseCase(self.port, ChangeSpaceSortUseCase.Input.init(spaces: spaces)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    //self?.spaces = publisherReponse.success!
                }else {
                    self?.state = ViewState.ERROR
                    //self?.spaces = []
                }
            }
            .store(in: &disposables)
    }
    
}
