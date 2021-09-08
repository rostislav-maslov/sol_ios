//
//  TaskItemViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation
import Combine

protocol TaskItemViewModelProtocol {
    func taskDidChange(task: TaskEntity) -> Void
}

public class TaskItemViewModel: ObservableObject {
    @Published var task: TaskEntity

    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task
    var delegate: TaskItemViewModelProtocol
    
    var changeId = UUID()
    
    init( task: TaskEntity, delegate: TaskItemViewModelProtocol) {
        self.task = task
        self.delegate = delegate
    }
}

extension TaskItemViewModel{
    func onTouchCheckbox(){
        if (task.status == TaskStatus.DONE) {
            self.task.status = TaskStatus.OPEN
            self.changeId = UUID()
            self.delegate.taskDidChange(task: self.task)
            SolPublisher<TaskEntity, Bool>(useCase: MakeTaskOpenUseCase(self.port, MakeTaskOpenUseCase.Input.of(self.task.id)))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] publisherReponse in
                    if publisherReponse.success != nil {
                        self?.task.status = publisherReponse.success!.status
                        self?.delegate.taskDidChange(task: self!.task)
                    }else {

                    }
                }
                .store(in: &disposables)
            return
        }
        
        if (task.status == TaskStatus.OPEN) {
            self.task.status = TaskStatus.DONE
            self.changeId = UUID()
            self.delegate.taskDidChange(task: self.task)
            SolPublisher<TaskEntity, Bool>(useCase: MakeTaskDoneUseCase(self.port, MakeTaskDoneUseCase.Input.of(self.task.id)))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] publisherReponse in
                    if publisherReponse.success != nil {
                        self?.task.status = publisherReponse.success!.status
                        self?.delegate.taskDidChange(task: self!.task)
                    }else {
                    }
                }
                .store(in: &disposables)
            return
        }
    }
}
