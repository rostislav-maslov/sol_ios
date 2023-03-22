//
//  SlotsCalendarModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.10.2021.
//

import Foundation
import Combine
import SwiftUI
import EventKit
import CalendarKit



public class PlanningSlotsModel: NSObject, ObservableObject, DayViewControllerProtocol {
    @Published var isPresented: Bool = false
    
    @Published var title = "Plan your work"
    @Published var newSlotTitle = ""
    @Published var newSlotColor = UIColor(SolColor.colors().fontColors.normal)
    @Published var openFromSpaceId: String = ""
    @Published var openFromTaskId: String = ""
    
    @Published var state = ViewState.NORMAL
    
    @Published var type: PlanningType = PlanningType.TASK
    
    @Published var allSlots: [SlotEntity] = []
    @Published var drafts: [SlotEntity] = []
    
    @Published var dayViewControllerImpl:DayViewControllerImpl = DayViewControllerImpl()
        
    @Published var slotModel: SlotModel = SlotModel()
    
    var spaceStore: SpaceStore?
    var taskStore: TaskStore?
    var slotStore: SlotStore?
}

// MARK: DayViewControllerProtocol
extension PlanningSlotsModel {

    private func syncDrafts(){
        //Получаем инфу о черновиках
        var needAddDraft:[SlotEntity] = []
        for slotDraft in drafts {
            var hasSlot = false
            for slot in self.allSlots {
                if slot.id == slotDraft.id {
                    hasSlot = true
                    break
                }
            }
            
            if hasSlot == false {
                needAddDraft.append(slotDraft)
            }
        }
        if needAddDraft.count > 0 {
            self.allSlots.append(contentsOf: needAddDraft)
            DispatchQueue.main.async {
                self.dayViewControllerImpl.reloadData()
            }
        }
    }
    
    public func newEventTitle() -> String {
        return self.newSlotTitle
    }
       
    public func newEventColor() -> UIColor {
        return self.newSlotColor
    }
  
    public func eventsForDate(_ date: Date) -> [EventDescriptor] {
        //Получаем инфу о событиях дня. после создание запрашивается заново все события дня
        slotStore?.syncByDay(day: date) { results in
            var needAdd: [SlotEntity] = []
            
            for result in results {
                var hasSlot = false
                for slot in self.allSlots {
                    if slot.id == result.id {
                        hasSlot = true
                        break
                    }
                }
                
                if hasSlot == false {
                    needAdd.append(result)
                }
            }
            
            if needAdd.count > 0 {
                self.allSlots.append(contentsOf: needAdd)
                DispatchQueue.main.async {
                    self.dayViewControllerImpl.reloadData()
                }
            }
            
            self.syncDrafts()
        }
        
        var result:[EventDescriptor] = []
        for slot in allSlots {
            let formatter = DateFormatter()
            formatter.dateFormat = "ddMMyyyy"
            
            let firstTime:String = formatter.string(from: date)
            let startTime:String = formatter.string(from: slot.startTime!)
            let endTime:String = formatter.string(from: slot.endTime!)

            if firstTime == startTime || firstTime == endTime {
                result.append(slot.updateAndReturnDescriptor())
            }
        }
        return result
    }
    
    // MARK: Create Event
    public func createEvent(eventDescriptor: EventDescriptor) -> Void {
        // TOOD
        let startTime = eventDescriptor.dateInterval.start,
            endTime = eventDescriptor.dateInterval.end
        if type == .TASK_CREATE{
            let slot: SlotEntity = SlotEntity()
            slot.id = UUID().uuidString
            slot.title = newSlotTitle
            slot.startTime = startTime
            slot.endTime = endTime
            //slot.spaceId = self.spaceId
            slot.slotsMilliseconds = endTime.millisecondsSince1970 - startTime.millisecondsSince1970
            slot.isDraft = true
            slot.timezone = Date().timezone
            drafts.append(slot)
            syncDrafts()
        }else if type == .TASK{
            slotStore?.create(startTime: startTime, endTime: endTime, taskId: openFromTaskId)
        }
    }
    
    // MARK: Edit Event
    public func updateEvent(eventDescriptor: EventDescriptor) -> Void{
        // запускается когда мы хотим обновить событие в календаре
        //TODO
        if let ev:CalendarKit.Event = eventDescriptor.editedEvent as? CalendarKit.Event {
            if let slotId:String = ev.userInfo as? String {
                for slot in allSlots {
                    if slotId == slot.id {
                        slot.startTime = eventDescriptor.dateInterval.start
                        slot.endTime = eventDescriptor.dateInterval.end
                        
                        // Commit changes
                        if slot.isDraft == true {
                            //тут обновляяем в драфтах
                            //delegate.changeTimeSlot(slotId: slotId, startTime: eventDescriptor.startDate, endTime: eventDescriptor.endDate)
                        } else {
                            //а тут обновляем в этих самых
                            let req = SlotUpdateRequest(
                                endTime: eventDescriptor.dateInterval.end.millisecondsSince1970,
                                startTime: eventDescriptor.dateInterval.start.millisecondsSince1970,
                                id: slotId,
                                timezone: Date().timezone)
                          
                            slotStore
//                            slot.edit(req, responseFunc: { success, error, isSuccess in
//                                print(isSuccess)
//                            })
                        }
                    }
                }
                
            }
        }
        
    }
    
    // MARK: Did tap on event
    public func didSelectEvent(eventDescriptor: Event) {
        let slotId: String = eventDescriptor.userInfo as! String
        for slot in allSlots {
            if slot.id == slotId {
                onTapEvent(slot: slot)
                // вот тут перезапрашиваем
            }
        }
    }
    
}

// MARK: PlanningSlots Events
extension PlanningSlotsModel{
    func clear(){
        allSlots = []
        drafts = []
        DispatchQueue.main.async {
            self.dayViewControllerImpl.reloadData()
        }
    }
    func onClose() {
        isPresented = false
    }
    
    func onSubmit() {
        isPresented = false
    }
    
    func onTapEvent(slot: SlotEntity) {
        slotModel.slot = slot
        
        if slotModel.slot?.isDraft == false {
            taskStore?.syncTask(taskId: slotModel.slot!.createdFromTaskId!)
            slotModel.taskId = slotModel.slot?.createdFromTaskId
            slotModel.spaceId = slotModel.slot?.spaceId
        }
        
        slotModel.canGoToTask = (type == .TASK || type == .ALL || type == .SPACE) && (slotModel.slot?.isDraft == false)
        isPresented = false
        slotModel.isPresented = true        
    }
    
    func deleteDraft(slotId: String) {
        for key in 0...drafts.count {
            if drafts[key].id == slotId {
                drafts.remove(at: key)
                return
            }
        }
    }
    
    func deleteSlot(slotToDeleteId: String){
        for key in 0...allSlots.count{
            if allSlots[key].id == slotToDeleteId {
                if allSlots[key].isDraft == false {
                    slotStore?.delete(slotId: slotToDeleteId)
                }else{
                    deleteDraft(slotId: slotToDeleteId)
                }
                allSlots.remove(at: key)
                break
            }
        }
        slotModel.isPresented = false
        isPresented = true
        DispatchQueue.main.async {
            self.dayViewControllerImpl.reloadData()
        }
    }
}

