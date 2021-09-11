//
//  SpaceViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 05.08.2021.
//

import Foundation
import SwiftUI
import Combine

public class SpaceViewModel: NSObject, ObservableObject{
    var spaceId:String
    @Published var state: ViewState = ViewState.INITIALIZATION
    var spaceStore: SpaceStore?
    
    @Published var activeTab = 0
    @Published var activeTabMax = 1
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    @Published var actionDone = false
        
    @Published var bottomButtonType: BottomButtonType = BottomButtonType.ADD_TASK
    var emojiTextField:UIEmojiTextField?
    
    
    public var scrollViewProxy:ScrollViewProxy?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    private let portTasks:TaskRepositoryPort = SolApiService.api().task
    
    init(_ spaceId:String){
        self.spaceId = spaceId                
    }
    
    func load(){
        spaceStore?.sync(spaceId: self.spaceId)                
    }
    
}

extension SpaceViewModel {
    static func forRender() -> SpaceViewModel{
        let s = SpaceViewModel("111")
        //s.space.title = "asfdasf asdf asd f"
        //s.space.icon.data = "😀"
        return s
    }
}
