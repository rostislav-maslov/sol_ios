//
//  SlotStore.swift
//  SOL
//
//  Created by Rostislav Maslov on 18.10.2021.
//

import Foundation
import Combine

public class SlotStore: ObservableObject {
    @Published var slots:[String: SlotEntity] = [String: SlotEntity]()
    //@Published var slotsByDay:[String: [SlotEntity]] = [String: [SlotEntity]]()
    //@Published var slotsByTask:[String: [SlotEntity]] = [String: [SlotEntity]]()
    @Published var forNotifyCombine = UUID()
    
    var taskStore: TaskStore?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SlotRepositoryPort = SolApiService.api().slot
}

//MARK: - Загрузка
extension SlotStore {
    func dayKey(day: Date) -> String{
        let calenderDate = Calendar.current.dateComponents([.day, .year, .month], from: day)
        return "\(calenderDate.year!)\(calenderDate.month!)\(calenderDate.day!)"
    }
    
    func syncByDay(day: Date, callback: @escaping (([SlotEntity]) -> Void)){
        
        SolPublisher<[SlotEntity], Bool>(useCase: FindSlotByDayUseCase(self.port, FindSlotByDayUseCase.Input(date: day)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let slots:[SlotEntity] = publisherReponse.success!
                    for slot in slots {
                        self?.slots[slot.id] = slot
                    }
                    callback(slots)
                }else {
                }
            }
            .store(in: &disposables)
    }
    
    func syncByTask(taskId: String, callback: @escaping (([SlotEntity]) -> Void)){
        SolPublisher<[SlotEntity], Bool>(useCase: FindSlotTaskUseCase(self.port, FindSlotTaskUseCase.Input(taskId: taskId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] publisherReponse in
                if publisherReponse.success != nil {
                    let slots:[SlotEntity] = publisherReponse.success!
                    for slot in slots {
                        self?.slots[slot.id] = slot
                    }
                    callback(slots)
                }else {
                }
            }
            .store(in: &disposables)
    }
}

//MARK: - Изменение
extension SlotStore {
    
    
    
}

//MARK: - Создание таска
extension SlotStore {
    func create( startTime: Date, endTime: Date, taskId: String){
        SolPublisher<SlotEntity, Bool>(useCase:
                                        CreateSlotUseCase(self.port,
                                                          CreateSlotUseCase.Input.init(
                                                            taskId: taskId, startTime: startTime, endTime: endTime)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                if(result.success != nil) {
                    let slot:SlotEntity = result.success!
                    self?.slots[slot.id] = slot
                    self?.taskStore?.tasks[taskId]?.slots.append(slot)
                    self?.taskStore?.tasks[taskId]?.slotsMilliseconds += slot.slotsMilliseconds
                    self?.forNotifyCombine = UUID()
                }
            }
            .store(in: &disposables)
    }
    
    func edit(slot: SlotEntity){
        SolPublisher<SlotEntity, Bool>(useCase:
                                        EditSlotUseCase(self.port,
                                                        EditSlotUseCase.Input(
                                                            slotId: slot.id, startTime: slot.startTime!, endTime: slot.endTime!)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                if(result.success != nil) {
                    let slot:SlotEntity = result.success!
                    self?.slots[slot.id] = slot
                    self?.taskStore?.syncTask(taskId: slot.createdFromTaskId!)
                    self?.forNotifyCombine = UUID()
                }
            }
            .store(in: &disposables)
    }
  
    func delete(slotId: String){
        if slots[slotId] == nil {
            return
        }
        
        let taskId = slots[slotId]?.createdFromTaskId
        
        SolPublisher<String, Bool>(useCase:
                                        DeleteSlotUseCase(self.port,
                                                          DeleteSlotUseCase.Input.init(
                                                            slotId: slotId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                if(result.success != nil) {
                    self?.slots.removeValue(forKey: slotId)
                    if taskId != nil {
                        self?.taskStore?.syncTask(taskId: taskId!)
                    }
                    self?.forNotifyCombine = UUID()
                }
            }
            .store(in: &disposables)
    }
    
}

