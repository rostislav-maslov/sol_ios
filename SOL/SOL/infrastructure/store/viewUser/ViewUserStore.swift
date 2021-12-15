//
//  ViewUserStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation
import Combine

public class ViewUserStore: ObservableObject {
    @Published var all:[String: ViewUserEntity] = [String: ViewUserEntity]()
    @Published var root:[ViewUserEntity] = []
    @Published var byTask:[String: [TaskInViewResponse]] = [String: [TaskInViewResponse]]()
    @Published var byView:[String: [TaskInViewResponse]] = [String: [TaskInViewResponse]]()
    
    @Published var showAddToViewCount = 0
    @Published var showAddToViewLimit = 5
    
    var taskStore: TaskStore?
    
    private var disposables = Set<AnyCancellable>()
    private let port:ViewUserRepositoryPort = SolApiService.api().view
}

//MARK: - Загрузка
extension ViewUserStore {
    
//    func syncShowAddToViewCount(){
//        UserDefaults.
//    }
//    
//    func addShowTo 
    
    func toggleTaskInView(taskId: String, viewId: String){
        if self.byTask[taskId] == nil {
            createTaskInView(taskId: taskId, viewId: viewId)
        }
        
        if self.byTask[taskId]!.contains(where: { taskInView in
            return viewId == taskInView.viewId
        }) == true {
            deleteTaskInView(taskId: taskId, viewId: viewId)
        }else {
            createTaskInView(taskId: taskId, viewId: viewId)
        }
    }
    
    func deleteTaskInView(taskId: String, viewId: String){
        SolPublisher<String, Bool>(useCase: DeleteTaskInViewUseCase(self.port, input: DeleteTaskInViewUseCase.Input(taskId: taskId, viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {

                    if self?.byTask[taskId] == nil {
                        return
                    }
                    
                    let views: [TaskInViewResponse] = self!.byTask[taskId]!
                    self?.byTask[taskId] = views.filter {$0.viewId != viewId}
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func createTaskInView(taskId: String, viewId: String){
        SolPublisher<String, Bool>(useCase: CreateTaskInViewUseCase(self.port, input: CreateTaskInViewUseCase.Input(taskId: taskId, viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {                    
                    var views: [TaskInViewResponse] = []
                    if self?.byTask[taskId] != nil {
                        views = self!.byTask[taskId]!
                    }
                    
                    if views.contains(where: { taskInView in
                        return taskInView.viewId == viewId
                    }) == false {
                        views.append(TaskInViewResponse(viewId: viewId, sortNum: 0, taskId: taskId))
                    }
                                        
                    self?.byTask[taskId] = views
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func syncByTask(taskId: String){
        SolPublisher<[TaskInViewResponse], Bool>(useCase: FindByTaskUseCase(self.port, input: FindByTaskUseCase.Input(taskId: taskId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let ids = publisherReponse.success!
                    var res:[ViewUserEntity] = []
                    for view in ids {
                        if self?.all[view.viewId!] != nil {
                            res.append(self!.all[view.viewId!]!)
                        }
                    }
                    self?.byTask[taskId] = ids
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func syncTaskInView(viewId: String){
        SolPublisher<[TaskInViewResponse], Bool>(useCase: FindByViewUseCase(self.port, input: FindByViewUseCase.Input(viewId: viewId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let taskInViews = publisherReponse.success!
                    for taskInView in taskInViews {
                        self?.taskStore?.syncTask(taskId: taskInView.taskId!, silent: true)
                    }
                    self?.byView[viewId] = taskInViews
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func sync(){
        SolPublisher<[ViewUserEntity], Bool>(useCase: GetRootViewUserUseCase(self.port, input: GetRootViewUserUseCase.Input()))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let views = publisherReponse.success!
                    
                    for view in views {
                        self?.all[view.id] = view
                    }
                    
                    self?.root = views
                }else {
                }                               
            }
            .store(in: &disposables)
    }
}
