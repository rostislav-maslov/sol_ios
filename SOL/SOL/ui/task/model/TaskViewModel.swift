//
//  TaskViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation
import Combine

public class TaskViewModel: ObservableObject {
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
    var activeTabMax = 3
    
    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task
    
    
    init(task: TaskEntity){
        self.task = task
        self.taskId = task.id
        self.state = ViewState.NORMAL
    }
    
    init( taskId: String, spaceId: String ){
        self.taskId = taskId
        self.task = TaskEntity()
        self.task.id = taskId
        self.task.spaceId = spaceId
        self.state = ViewState.INITIALIZATION        
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
        self.task.child.insert(taskEntity, at: 0)
        self.task.hasChild = true
        self.listIdHack = UUID()
    }
}
