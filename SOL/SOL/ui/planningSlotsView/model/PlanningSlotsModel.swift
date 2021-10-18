//
//  SlotsCalendarModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.10.2021.
//

import Foundation
import Combine
import SwiftUI

public class PlanningSlotsModel: NSObject, ObservableObject, DaySchedulerProtocol {
       
    @Published var canGoToTask: Bool = false
    @Published var title: String = ""
    @Published var slotId: String = ""
    @Published var spaceId: String = ""
    @Published var taskId: String = ""
    @Published var showPlanningSlot: Bool = false
    @Published var delegate: DaySchedulerProtocol?
    @Published var state = ViewState.NORMAL
    @Published var slotStore:SlotStore?
    @Published var type: PlanningType = PlanningType.VIEW
    @Published var needUpdate: Bool = false
    
    var needClose : (() -> Void)?
    
    func deleteSlot(slotToDeleteId: String){
        if slotStore?.slots[slotToDeleteId] != nil && slotStore?.slots[slotToDeleteId]?.isDraft == false {
            slotStore?.delete(slotId: slotToDeleteId)
        }else{
            delegate?.onDeleteDraft(slotId: slotToDeleteId)
        }
        showPlanningSlot = false
        needUpdate = true
    }
}

extension PlanningSlotsModel{
    func newSlotName() -> String {
        return delegate?.newSlotName() ?? ""
    }
    
    func drafts() -> [SlotEntity] {
        return delegate?.drafts() ?? []
    }
    
    func addSlot(startTime: Date, endTime: Date) {
        delegate?.addSlot(startTime: startTime, endTime: endTime)
    }
    
    func changeTimeSlot(slotId: String, startTime: Date, endTime: Date) {
        delegate?.changeTimeSlot(slotId: slotId, startTime: startTime, endTime: endTime)
    }
    
    func onClose() {
        delegate?.onClose()
        needClose?()
    }
    
    func onSubmit() {
        delegate?.onSubmit()
        needClose?()
    }
    
    func onTapEvent(slot: SlotEntity) {
        
        canGoToTask = (type == PlanningType.VIEW)
        title = slot.title
        slotId = slot.id
        taskId = slot.createdFromTaskId != nil ? slot.createdFromTaskId! : ""
        spaceId = "" // TODO: тут понять откуда лучше брать spaceId
        
        //modalViewModel.slot = slot
        showPlanningSlot = true
    }
    
    func onDeleteDraft(slotId: String) {
        delegate?.onDeleteDraft(slotId: slotId)
    }
}

