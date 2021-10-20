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
    var spaceId:String?
    @Published var state: ViewState = ViewState.INITIALIZATION
    var spaceStore: SpaceStore?
    var slotStore: SlotStore?
    
    @Published var activeTab = 0
    @Published var activeTabMax = 1
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    @Published var actionDone = false
    @Published var showPlanning = false
    @Published var stopEditIcon = false
    @Published var emoji = ""
    
    @Published var bottomButtonType: BottomButtonType = BottomButtonType.ADD_TASK
    var emojiTextField:UIEmojiTextField?
            
    public var scrollViewProxy:ScrollViewProxy?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
    private let portTasks:TaskRepositoryPort = SolApiService.api().task
    
    func load(){
        spaceStore?.sync(spaceId: self.spaceId!)                
    }
    
}

extension SpaceViewModel {
    static func forRender() -> SpaceViewModel{
        let s = SpaceViewModel()
        //s.space.title = "asfdasf asdf asd f"
        //s.space.icon.data = "😀"
        return s
    }
    
    func taskDidCreated() -> Void {
        withAnimation {
            scrollViewProxy?.scrollTo("ListLastItem", anchor: .bottom)
        }        
    }
}

