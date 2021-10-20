//
//  TaskViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation
import Combine
import SwiftUI

public class TaskViewModel: NSObject, ObservableObject {
    
    var taskStore: TaskStore?
    var slotStore: SlotStore?
    @Published var state: ViewState = ViewState.INITIALIZATION
    
    @Published var taskId: String = ""
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    // @Published var actionDone = false
    @Published var activeTab = 0
    //@Published var showPlanning = false
    @Published var stopEditIcon = false
    @Published var emoji = ""
    @Published var placeholder = ""    
    
    @Published var isTarget = true
    @Published var bottomButtonType: BottomButtonType = BottomButtonType.ADD_TASK
    @Published var emojiTextField:UIEmojiTextField?
    
    var activeTabMax = 3
    
    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task
    
    public var scrollViewProxy:ScrollViewProxy?
        
}

extension TaskViewModel {
   
    func toggleTask(){
        taskStore?.changeStatus(taskId: taskId)
    }
}

extension TaskViewModel{
    
    func taskDidCreated() -> Void{
        withAnimation {
            self.scrollViewProxy?.scrollTo("ListLastItem", anchor: .bottom)
        }
    }
}


