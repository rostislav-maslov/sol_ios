//
//  SpaceStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import Foundation
import Combine

public class SpaceStore: ObservableObject {
    @Published var spaces:[String: SpaceEntity] = [String: SpaceEntity]()
    @Published var spacesOrdered:[SpaceEntity] = []
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    
    func sync(){
        SolPublisher<[SpaceEntity], Bool>(useCase: MySpacesUseCase(self.port))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    for space in publisherReponse.success! {
                        self?.spaces[space.id] = space
                    }
                    self?.spacesOrdered = publisherReponse.success!
                } else {
                        //TODO: коллекционировать ошибки тут нужно
                }                          
            }
            .store(in: &disposables)
    }
}

extension SpaceStore {
    func reorderSpaces(draggetSpaceId: String, dropOnSpaceId: String) -> Bool{
        if (draggetSpaceId == dropOnSpaceId) {
            return false
        }
        
        var draggetSpaceIndex: Int? = nil
        for index in 0...(spacesOrdered.count - 1) {
            if (spacesOrdered[index].id == draggetSpaceId) {
                draggetSpaceIndex = index
            }
        }
        if draggetSpaceIndex == nil  {
            return false
        }
        let space = spacesOrdered.remove(at: draggetSpaceIndex!)
        
        var dropOnSpaceIndex: Int? = nil
        for index in 0...(spacesOrdered.count - 1) {
            if (spacesOrdered[index].id == dropOnSpaceId) {
                dropOnSpaceIndex = index
            }
        }
        if  dropOnSpaceIndex == nil {
            return false
        }
        
        spacesOrdered.insert(space, at: dropOnSpaceIndex!)
        commitNewSort()
        return true
    }
    
    func moveSpaceToEnd(draggetSpaceId: String) -> Bool{
        if (draggetSpaceId == spacesOrdered[spacesOrdered.count - 1].id) {
            return false
        }
        
        var draggetSpaceIndex: Int? = nil
        for index in 0...(spacesOrdered.count - 1) {
            if (spacesOrdered[index].id == draggetSpaceId) {
                draggetSpaceIndex = index
            }
        }
        if draggetSpaceIndex == nil  {
            return false
        }
        let space = spacesOrdered.remove(at: draggetSpaceIndex!)
        spacesOrdered.insert(space, at: spacesOrdered.endIndex)
        commitNewSort()
        return true
    }
    
    func commitNewSort(){
        var spaces:[String] = []
        
        for space in self.spacesOrdered {
            spaces.append(space.id)
        }
        
        SolPublisher<[SpaceEntity], Bool>(useCase: ChangeSpaceSortUseCase(self.port, ChangeSpaceSortUseCase.Input.init(spaces: spaces)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    //self?.spaces = publisherReponse.success!
                }else {                    
                    //self?.spaces = []
                }
            }
            .store(in: &disposables)
    }
}
