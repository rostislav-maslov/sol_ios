//
//  SpaceStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import Foundation
import Combine
import SwiftUI

public class SpaceStore: ObservableObject {
    @Published var spaces:[String: SpaceEntity] = [String: SpaceEntity]()
    @Published var spacesOrdered:[SpaceEntity] = []
    @Published var lastUpdateUUID = UUID()
    var taskStore: TaskStore?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    
    func getNonEmptySpace(spaceId: String) -> Binding<SpaceEntity> {
        return Binding<SpaceEntity> {
            if self.spaces[spaceId] != nil {
                return self.spaces[spaceId]!
            }
            
            let space: SpaceEntity = SpaceEntity()
            space.id = spaceId
            //TODO
            
            return space
        } set: { (spaceEntiry:SpaceEntity) in
            self.spaces[spaceId] = spaceEntiry
        }

    }
    
    
}

extension SpaceStore {
    func sync(){
        SolPublisher<[SpaceEntity], Bool>(useCase: MySpacesUseCase(self.port))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    for space in publisherReponse.success! {
                        self?.spaces[space.id] = space                       
                    }
                    self?.spacesOrdered = publisherReponse.success!
                    for space in publisherReponse.success! {
                        //self?.sync(spaceId: space.id)
                    }
                    self?.lastUpdateUUID = UUID()
                } else {
                        //TODO: коллекционировать ошибки тут нужно
                }
            }
            .store(in: &disposables)
    }
    
    func sync(spaceId : String){
        SolPublisher<SpaceEntity, Bool>(useCase: SpaceUseCase(self.port, SpaceUseCase.Input.of(spaceId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    for task in publisherReponse.success!.tasks {
                        self?.taskStore?.addLazyTask(taskId: task.id)
                    }
                    self?.spaces[spaceId] = publisherReponse.success!
                    print(self?.spaces[spaceId]?.title)
                    self?.lastUpdateUUID = UUID()
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func syncTasks(){
        if taskStore != nil {
            for space in spaces {
                for task in space.value.tasks {
                    taskStore?.syncTask(taskId: task.id)
                }
            }
        }
    }
    
    public func saveTitleIcon(spaceId: String, title: String, data: String){
        self.spaces[spaceId]?.title = title
        self.spaces[spaceId]?.icon.data = data
        
        SolPublisher<SpaceEntity, Bool>(useCase:
                                            UpdateTitleIconSpaceUseCase(
                                                self.port,
                                                UpdateTitleIconSpaceUseCase.Input.init(
                                                    id: spaceId,
                                                    title: title,
                                                    emoji: data)))
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] publisherReponse in
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
        lastUpdateUUID = UUID()
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
        lastUpdateUUID = UUID()
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
                    self?.lastUpdateUUID = UUID()
                }else {                    
                    //self?.spaces = []
                }
            }
            .store(in: &disposables)
    }
}
