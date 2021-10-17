//
//  SpacesViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation
import Combine

public class SpacesViewModel: ObservableObject, DaySchedulerProtocol {

    
    
    @Published var goToLogout: Bool = false
    @Published var showAddSpaceSheet: Bool = false
    @Published var state: ViewState = ViewState.INITIALIZATION
    @Published var defaultTaskAddTitle = "in Inbox"
    @Published var isTarget = true
    @Published var showPlanning = false    
    
    var store: SpaceStore?
    
    private var disposables = Set<AnyCancellable>()
    private let port:SpaceRepositoryPort = SolApiService.api().space
}

extension SpacesViewModel{
    public func onAddSpacesTouch () -> Void {
        showAddSpaceSheet = true
    }
    
    public func onDissmisAddSpace () -> Void {
        showAddSpaceSheet = false
    }
    
    public func taskDidCreated () -> Void {
        
    }
}


//MARK: DaySchedulerProtocol
extension SpacesViewModel {
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
