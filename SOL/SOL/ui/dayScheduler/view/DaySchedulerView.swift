//
//  CalendarView.swift
//  SOL
//
//  Created by Rostislav Maslov on 13.07.2021.
//

import Foundation
import Foundation
import SwiftUI
import EventKit
import CalendarKit

struct DaySchedulerView: UIViewControllerRepresentable, DayViewControllerProtocol {
    @ObservedObject var model:AddTaskViewModel
    
    func newEventTitle() -> String {
        return model.task.title
    }
    
    private func createEventDescriptor(_ slot: SlotEntity,_ task: TaskEntity) -> EventDescriptor{
        let event:Event = Event()
        
        event.startDate = slot.startDate!
        event.endDate = slot.endDate!
        event.userInfo = slot.id
        event.isAllDay = false
        //var info = ""// TODO data[Int(arc4random_uniform(UInt32(data.count)))]
        
        //info.append(rangeFormatter.string(from: event.startDate, to: event.endDate))
        event.text = task.fullTitle
        event.color = UIColor.red
        return event
    }
    
    func eventsForDate(_ date: Date) -> [EventDescriptor] {
        //TODO: тут нужно добавить инфу про остальные события
        
        var result:[EventDescriptor] = []
        
        for slot in model.task.slots {
            let formatter = DateFormatter()
            formatter.dateFormat = "ddMMyyyy"
            
            let firstDate:String = formatter.string(from: date)
            let startDate:String = formatter.string(from: slot.startDate!)
            let endDate:String = formatter.string(from: slot.endDate!)
            
            if firstDate == startDate || firstDate == endDate {
                result.append(createEventDescriptor(slot, model.task))
            }
        }
        
        return result
    }
    
    func newEventColor() -> UIColor {
        return UIColor.red
    }
    
    func createEvent(eventDescriptor: EventDescriptor) -> Void {
        model.addTimeSlot(startDate: eventDescriptor.startDate, endDate: eventDescriptor.endDate)
    }
    
    func updateEvent(eventDescriptor: EventDescriptor) -> Void{
        if let ev:CalendarKit.Event = eventDescriptor.editedEvent as? CalendarKit.Event {
            if let slotId:String = ev.userInfo as? String {
                model.changeTimeSlot(id: slotId, newStartDate: eventDescriptor.startDate, newEndDate: eventDescriptor.endDate)
            }
        }
    }
    
    
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){                
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let dayViewController = DayViewControllerImpl()
        dayViewController.eventDelegate = self
        dayViewController.title = "Schedule task work"
        
        return dayViewController
    }
    
    
}
