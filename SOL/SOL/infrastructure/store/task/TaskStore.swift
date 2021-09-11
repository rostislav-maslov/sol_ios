//
//  TaskStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import Foundation
import Combine

public class TaskStore: ObservableObject {
    @Published var tasks:[String: TaskEntity] = [String: TaskEntity]()
    @Published var lastUpdateUUID = UUID()
    
    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task
    
    
}

//MARK: - Загрузка
extension TaskStore {
    func addLazyTask(taskId: String){
        if tasks[taskId] == nil {
            //TODO: -
            tasks[taskId] = TaskEntity()
            tasks[taskId]!.id = taskId
        }
    }
    
    func syncTask(taskId: String){
        if tasks[taskId] == nil {
            //TODO: - 
            tasks[taskId] = TaskEntity()
            tasks[taskId]!.id = taskId
        }
        SolPublisher<TaskEntity, Bool>(useCase: TaskUseCase(self.port, TaskUseCase.Input.of(taskId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let task = publisherReponse.success!
                    for child in task.child {
                        self?.syncTask(taskId: child.id)
                    }
                    self?.tasks[taskId] = task
                }else {
                }
                self?.lastUpdateUUID = UUID()
            }
            .store(in: &disposables)
    }
}

//MARK: - Изменение
extension TaskStore {
    func changeStatus(taskId: String){
        let task:TaskEntity = tasks[taskId]!
        
        if (task.status == TaskStatus.DONE) {
            task.status = TaskStatus.OPEN
            SolPublisher<TaskEntity, Bool>(useCase: MakeTaskOpenUseCase(self.port, MakeTaskOpenUseCase.Input.of(task.id)))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] publisherReponse in
                    if publisherReponse.success != nil {
                        self?.tasks[taskId]!.status = publisherReponse.success!.status
                    }else {
                    }
                    self?.lastUpdateUUID = UUID()
                }
                .store(in: &disposables)
            return
        }
        
        if (task.status == TaskStatus.OPEN) {
            task.status = TaskStatus.DONE
            SolPublisher<TaskEntity, Bool>(useCase: MakeTaskDoneUseCase(self.port, MakeTaskDoneUseCase.Input.of(task.id)))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] publisherReponse in
                    if publisherReponse.success != nil {
                        self?.tasks[taskId]!.status = publisherReponse.success!.status
                    }else {
                    }
                    self?.lastUpdateUUID = UUID()
                }
                .store(in: &disposables)
            return
        }
    }
    
    func saveTitleIcon(taskId: String) {
        saveTitleIcon(taskId: taskId, title: tasks[taskId]!.title, iconData: tasks[taskId]!.icon.data)        
    }
    
    func saveTitleIcon(taskId: String, title: String, iconData: String) {
        tasks[taskId]?.title = title
        tasks[taskId]?.icon.data = iconData
        
        SolPublisher<TaskEntity, Bool>(
            useCase: EditTitleAndIconTaskUseCase(
                self.port,
                EditTitleAndIconTaskUseCase.Input.of(taskId, title, iconData)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                }else {                    
                }
                self?.lastUpdateUUID = UUID()
            }
            .store(in: &disposables)
    }
}

//MARK: - СОРТИРОВКА
extension TaskStore {
    func reorderTasks(parentTaskId:String, draggetTaskId: String, dropOnTaskId: String) -> Bool{
        let task:TaskEntity = tasks[parentTaskId]!
        
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
        var toCommint:[String] = []
        for ttt in task.child {
            toCommint.append(ttt.id)
        }
        
        commitNewSort(tasksToSort: toCommint)
        return true
    }
    
    func moveTaskToEnd(parentTaskId: String, draggetTaskId: String) -> Bool{
        let task:TaskEntity = tasks[parentTaskId]!
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
        var toCommint:[String] = []
        for ttt in task.child {
            toCommint.append(ttt.id)
        }
        commitNewSort(tasksToSort: toCommint)
        return true
    }
    
    private func commitNewSort(tasksToSort:[String]){
        SolPublisher<[TaskEntity], Bool>(useCase: ChangeSortTaskUseCase(self.port, ChangeSortTaskUseCase.Input.init(tasks: tasksToSort)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    for taskId in tasksToSort {
                        self?.syncTask(taskId: taskId)
                    }
                }else {
                }
            }
            .store(in: &disposables)
    }
}

