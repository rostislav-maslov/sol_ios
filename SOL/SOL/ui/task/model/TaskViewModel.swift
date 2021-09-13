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
    var taskId: String
    var taskStore: TaskStore?
    @Published var state: ViewState = ViewState.INITIALIZATION
    
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    @Published var actionDone = false
    @Published var activeTab = 0
    @Published var listIdHack = UUID()
    
    @Published var isTarget = true
    @Published var bottomButtonType: BottomButtonType = BottomButtonType.ADD_TASK
    @Published var emojiTextField:UIEmojiTextField?
    
    var activeTabMax = 3
    
    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task
    
    public var scrollViewProxy:ScrollViewProxy?
    
    init(taskId: String){
        self.taskId = taskId
        self.state = ViewState.INITIALIZATION
        
        
    }
}

extension TaskViewModel {
   
    func toggleTask(){
        taskStore?.changeStatus(taskId: taskId)
    }
    
         
    
}

extension TaskViewModel{
    
    func taskDidCreated(_ taskEntity: TaskEntity) -> Void{
        //self.task.child.append(taskEntity)
        //self.task.hasChild = true
        self.listIdHack = UUID()
        withAnimation {
            self.scrollViewProxy?.scrollTo("endOfScrollView", anchor: .bottom)
        }
    }
}


