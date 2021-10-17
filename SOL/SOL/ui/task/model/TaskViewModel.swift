//
//  TaskViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.07.2021.
//

import Foundation
import Combine
import SwiftUI

public class TaskViewModel: NSObject, ObservableObject, DaySchedulerProtocol {
    
    var taskStore: TaskStore?
    @Published var state: ViewState = ViewState.INITIALIZATION
    
    @Published var taskId: String = ""
    @Published var actionToggle:Bool = false
    @Published var actionRepeat:Bool = false
    @Published var actionNotification = false
    @Published var actionPlanning = false
    @Published var actionDeadline = false
    // @Published var actionDone = false
    @Published var activeTab = 0
    @Published var showPlanning = false
    
    
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


//MARK: DaySchedulerProtocol
extension TaskViewModel {
    func openPlanning() {
        showPlanning = true
    }
    
    func newSlotName() -> String {
        return ""
    }
    
    func addSlot(startTime: Date, endTime: Date) {
//        let slot: SlotEntity = SlotEntity()
//        slot.id = UUID().uuidString
//        slot.title = task.title
//        slot.startTime = startTime
//        slot.endTime = endTime
//        slot.spaceId = self.spaceId
//        slot.slotsMilliseconds = endTime.millisecondsSince1970 - startTime.millisecondsSince1970
//        slot.isDraft = true
//        slot.timezone = Date().timezone
//        task.slots.append(slot)
    }
    
    func slotsByDay(date: Date, callback: @escaping (([SlotEntity]) -> Void) ) {
        SolApiService.instance?.slot.findByDate(date.millisecondsSince1970, Date().timezone, responseFunc:   { (success, error, isSuccess) in
            var result:[SlotEntity] = []
            if isSuccess == true && success != nil {
                for item in success!.result.items{
                    result.append(SlotMapping.mapping(response: item))
                }
            }
            callback(result)
        })
    }
  
    func changeTimeSlot(slotId: String, startTime: Date, endTime: Date) {
        
    }
    
    func onClose() {
        showPlanning = false
    }
    
    func onSubmit() {
        showPlanning = false
    }
    
    func onTapEvent(slot: SlotEntity) {
        // NOTE ignore
    }
    
    func onDelete(slotId: String) {
        SolApiService.instance?.slot.delete(slotId, responseFunc: { success, error, isSuccess in
            
        })
    }

}
