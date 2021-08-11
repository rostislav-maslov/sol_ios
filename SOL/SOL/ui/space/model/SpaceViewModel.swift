//
//  SpaceViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import Combine

public class SpaceViewModel: NSObject, ObservableObject, UITextViewDelegate{
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
    @Published var titleSize:CGFloat = (24 + 8) * 1
    @Published var detectFirstSizeTitle:Bool = false
    @Published var firstSizeTitle:CGFloat = 0
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
    
    public func textViewDidChange(_ textView: UITextView) {
        let sizeThatFitsTextView = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView.height + 10
        space.title = textView.text
        self.titleSize = heightOfText
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            self.saveTitleIcon()            
        }
        return true
    }
}

extension SpaceViewModel{
    
    func taskDidCreated(_ taskEntity: TaskEntity) -> Void{
        self.space.tasks.insert(taskEntity, at: 0)
        self.listIdHack = UUID()
    }
}
