//
//  SpaceViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import Combine

public class SpaceViewModel: NSObject, ObservableObject, MultilineTextFieldProtocol{
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
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    
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
        self.space.tasks.insert(taskEntity, at: 0)
        self.listIdHack = UUID()
    }
}
