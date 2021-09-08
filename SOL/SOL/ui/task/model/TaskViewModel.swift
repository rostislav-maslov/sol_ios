//
//  TaskViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation
import Combine
import SwiftUI

public class TaskViewModel: NSObject, ObservableObject, MultilineTextFieldProtocol, TaskItemViewModelProtocol {
    var taskId: String
    @Published var task: TaskEntity
    @Published var state: ViewState = ViewState.INITIALIZATION
    
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    @Published var actionDone = false
    @Published var activeTab = 0
    @Published var listIdHack = UUID()
    
    @Published var bottomButtonType: BottomButtonType = BottomButtonType.ADD_TASK
    @Published var emojiTextField:UIEmojiTextField?
    
    var activeTabMax = 3
    
    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task
    public var scrollViewProxy:ScrollViewProxy?
    
    init(task: TaskEntity){
        self.task = task
        self.taskId = task.id
        self.state = ViewState.NORMAL
    }
    
    init( taskId: String, spaceId: String ){
        
        self.taskId = taskId
        
        self.state = ViewState.INITIALIZATION
        
        let task = TaskEntity()
        task.id = taskId
        task.spaceId = spaceId
        
        self.task = task
        
    }
}


extension TaskViewModel {
   
    func load(){
        self.state = ViewState.LOADING
        SolPublisher<TaskEntity, Bool>(useCase: TaskUseCase(self.port, TaskUseCase.Input.of(self.taskId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    self?.task = publisherReponse.success!
                    self?.actionDone == publisherReponse.success!.isDone()
                }else {
                    self?.state = ViewState.ERROR                    
                }
                self?.listIdHack = UUID()
            }
            .store(in: &disposables)

    }
}

extension TaskViewModel {
   
    func toggleTask(){
        if self.task.status == .DONE {
            makeOpen()
        }else{
            makeDone()
        }
    }
    
    func makeDone(){
        self.state = ViewState.LOADING
        self.actionDone = true
        SolPublisher<TaskEntity, Bool>(useCase: MakeTaskDoneUseCase(self.port, MakeTaskDoneUseCase.Input.of(self.taskId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    self?.task.status = publisherReponse.success!.status
                }else {
                    self?.state = ViewState.ERROR
                }
                self?.listIdHack = UUID()
            }
            .store(in: &disposables)
    }
    
    func makeOpen(){
        self.state = ViewState.LOADING
        self.actionDone = false
        SolPublisher<TaskEntity, Bool>(useCase: MakeTaskOpenUseCase(self.port, MakeTaskOpenUseCase.Input.of(self.taskId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    self?.task.status = publisherReponse.success!.status
                }else {
                    self?.state = ViewState.ERROR
                }
                self?.listIdHack = UUID()
            }
            .store(in: &disposables)
    }
    
    public func textDidChange(text: String) {
        task.title = text
    }
    
    public func textEditFinish(text: String) {
        task.title = text
        self.saveTitleIcon()
    }
    
    func saveTitleIcon() {
        SolPublisher<TaskEntity, Bool>(
            useCase: EditTitleAndIconTaskUseCase(
                self.port,
                EditTitleAndIconTaskUseCase.Input.of(task.id, task.title, task.icon.data)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    self?.state = ViewState.NORMAL
                    //self?.task = publisherReponse.success!
                }else {
                    self?.state = ViewState.ERROR
                }
                self?.listIdHack = UUID()
            }
            .store(in: &disposables)
    }
    
}

extension TaskViewModel{
    
    func taskDidCreated(_ taskEntity: TaskEntity) -> Void{
        self.task.child.append(taskEntity)
        self.task.hasChild = true
        self.listIdHack = UUID()
        withAnimation {
            self.scrollViewProxy?.scrollTo("endOfScrollView", anchor: .bottom)
        }
    }
}

extension TaskViewModel {
    func reorderTasks(draggetTaskId: String, dropOnTaskId: String) -> Bool{
        if (draggetTaskId == dropOnTaskId) {
            return false
        }
        
        var draggetTaskIndex: Int? = nil
        for index in 0...(task.child.count - 1) {
            if (task.child[index].id == draggetTaskId) {
                draggetTaskIndex = index
            }
        }
        if draggetTaskIndex == nil  {
            return false
        }
        let taskToChange = task.child.remove(at: draggetTaskIndex!)
        
        var dropOnTaskIndex: Int? = nil
        for index in 0...(task.child.count - 1) {
            if (task.child[index].id == dropOnTaskId) {
                dropOnTaskIndex = index
            }
        }
        if  dropOnTaskIndex == nil {
            return false
        }
        
        task.child.insert(taskToChange, at: dropOnTaskIndex!)
        commitNewSort()
        return true
    }
    
    func moveTaskToEnd(draggetTaskId: String) -> Bool{
        if (draggetTaskId == task.child[task.child.count - 1].id) {
            return false
        }
        
        var draggetTaskIndex: Int? = nil
        for index in 0...(task.child.count - 1) {
            if (task.child[index].id == draggetTaskId) {
                draggetTaskIndex = index
            }
        }
        if draggetTaskIndex == nil  {
            return false
        }
        let taskToChange = task.child.remove(at: draggetTaskIndex!)
        task.child.insert(taskToChange, at: task.child.endIndex)
        commitNewSort()
        return true
    }
    
    func commitNewSort(){
        var tasks:[String] = []
        
        for task in task.child {
            tasks.append(task.id)
        }
        
        SolPublisher<[TaskEntity], Bool>(useCase: ChangeSortTaskUseCase(self.port, ChangeSortTaskUseCase.Input.init(tasks: tasks)))
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


extension TaskViewModel {
    func taskDidChange(task: TaskEntity) {
        for index in 0...(self.task.child.count - 1) {
            if self.task.child[index].id == task.id {
                self.task.child[index] = task
            }
        }
        self.listIdHack = UUID()
    }
}
