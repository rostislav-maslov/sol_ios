//
//  SpaceViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import Combine

public class SpaceViewModel: NSObject, ObservableObject, MultilineTextFieldProtocol, TaskItemViewModelProtocol{
    @Published var spaceId:String
    @Published var space: SpaceEntity = SpaceEntity()
    @Published var state: ViewState = ViewState.INITIALIZATION
    @Published var activeTab = 0
    @Published var activeTabMax = 1
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    @Published var actionDone = false
        
    @Published var bottomButtonType: BottomButtonType = BottomButtonType.ADD_TASK
    @Published var emojiTextField:UIEmojiTextField?
    @Published var listIdHack = UUID()
    
    public var scrollViewProxy:ScrollViewProxy?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    private let portTasks:TaskRepositoryPort = SolApiService.api().task
    
    init(_ spaceId:String){
        self.spaceId = spaceId                
    }
    
    func load(){
        self.state = ViewState.LOADING
        SolPublisher<SpaceEntity, Bool>(useCase: SpaceUseCase(self.port, SpaceUseCase.Input.of(self.spaceId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    self?.space = publisherReponse.success!

                }else {
                    self?.state = ViewState.ERROR
                    self?.space = SpaceEntity()
                }                                
            }
            .store(in: &disposables)

    }
    
    public func saveTitleIcon(){
        SolPublisher<SpaceEntity, Bool>(useCase:
                                            UpdateTitleIconSpaceUseCase(
                                                self.port,
                                                UpdateTitleIconSpaceUseCase.Input.init(id: self.spaceId, title: self.space.title, emoji: space.icon.data)))
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] publisherReponse in
            }
            .store(in: &disposables)
    }
    
    public func textDidChange(text: String) {
        space.title = text
    }
    
    public func textEditFinish(text: String) {
        space.title = text
        self.saveTitleIcon()        
    }
    
    
}

extension SpaceViewModel{
    
    func taskDidCreated(_ taskEntity: TaskEntity) -> Void{
        self.space.tasks.append(taskEntity)
        
        self.listIdHack = UUID()
        withAnimation {
            self.scrollViewProxy?.scrollTo("endOfScrollView", anchor: .bottom)
        }
    }
}

extension SpaceViewModel {
    func reorderTasks(draggetTaskId: String, dropOnTaskId: String) -> Bool{
        if (draggetTaskId == dropOnTaskId) {
            return false
        }
        
        var draggetTaskIndex: Int? = nil
        for index in 0...(space.tasks.count - 1) {
            if (space.tasks[index].id == draggetTaskId) {
                draggetTaskIndex = index
            }
        }
        if draggetTaskIndex == nil  {
            return false
        }
        let task = space.tasks.remove(at: draggetTaskIndex!)
        
        var dropOnTaskIndex: Int? = nil
        for index in 0...(space.tasks.count - 1) {
            if (space.tasks[index].id == dropOnTaskId) {
                dropOnTaskIndex = index
            }
        }
        if  dropOnTaskIndex == nil {
            return false
        }
        
        space.tasks.insert(task, at: dropOnTaskIndex!)

        commitNewSort()
        return true
    }
    
    func moveTaskToEnd(draggetTaskId: String) -> Bool{
        if (draggetTaskId == space.tasks[space.tasks.count - 1].id) {
            return false
        }
        
        var draggetTaskIndex: Int? = nil
        for index in 0...(space.tasks.count - 1) {
            if (space.tasks[index].id == draggetTaskId) {
                draggetTaskIndex = index
            }
        }
        if draggetTaskIndex == nil  {
            return false
        }
        let task = space.tasks.remove(at: draggetTaskIndex!)
        space.tasks.insert(task, at: space.tasks.endIndex)         
        commitNewSort()
        return true
    }
    
    func commitNewSort(){
        var tasks:[String] = []
        
        for task in space.tasks {
            tasks.append(task.id)
        }
        
        SolPublisher<[TaskEntity], Bool>(useCase: ChangeSortTaskUseCase(self.portTasks, ChangeSortTaskUseCase.Input.init(tasks: tasks)))
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

extension SpaceViewModel {
    func taskDidChange(task: TaskEntity) {
        for index in 0...(self.space.tasks.count - 1) {
            if self.space.tasks[index].id == task.id {
                self.space.tasks[index] = task
            }
        }
        self.listIdHack = UUID()
    }
}

