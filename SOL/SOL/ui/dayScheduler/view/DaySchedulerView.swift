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

//Что делаем дальше:

//6 - подумать над тем, как мы будем удалять слоты, может дополнительное окно для редактирования слота
//7 - занести нужно это все в ToDo

protocol DaySchedulerProtocol {
    func newSlotName() -> String
    func slotsByDay(date: Date, callback:  @escaping (([SlotEntity]) -> Void) )
    func addSlot(startTime: Date, endTime: Date) -> Void
    func changeTimeSlot() -> Void
    func onSubmit() -> Void
    func onClose() -> Void
}

struct DaySchedulerView: UIViewControllerRepresentable, DayViewControllerProtocol {
    
    var delegate: DaySchedulerProtocol
    @State var reloadData: (() -> Void)?
    @State var allSots: [SlotEntity] = []
    var dayViewControllerImpl:DayViewControllerImpl = DayViewControllerImpl()
    
    func newEventTitle() -> String {
        return delegate.newSlotName()
    }
    
    private func createEventDescriptor(_ slot: SlotEntity,_ title: String) -> EventDescriptor{
        // Созданем описание события для того что бы добавить в календарь
        let event:Event = Event()
        
        event.startDate = slot.startTime!
        event.endDate = slot.endTime!
        event.userInfo = slot.id
        event.isAllDay = false
        //var info = ""// TODO data[Int(arc4random_uniform(UInt32(data.count)))]
        
        //info.append(rangeFormatter.string(from: event.startDate, to: event.endDate))
        event.text = title
        if slot.isDraft {
            //event.color = UIColor.red
            event.color = UIColor(SolColor.colors().fontColors.normal)
        }else{
            event.color = UIColor(SolColor.colors().fontColors.second)
        }
        
        return event
    }
    
    
    
    func eventsForDate(_ date: Date) -> [EventDescriptor] {
        //Получаем инфу о событиях дня. после создание запрашивается заново все события дня
        
        var result:[EventDescriptor] = []
        
        delegate.slotsByDay(date: date, callback: { (results: [SlotEntity]) in
            var needAdd: [SlotEntity] = []
            
            for result in results {
                var hasSlot = false
                for slot in self.allSots {
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
                self.allSots.append(contentsOf: needAdd)
                DispatchQueue.main.async {
                    self.dayViewControllerImpl.reloadData()
                }
            }
            
        })
        
        for slot in allSots {
            let formatter = DateFormatter()
            formatter.dateFormat = "ddMMyyyy"
            
            let firstTime:String = formatter.string(from: date)
            let startTime:String = formatter.string(from: slot.startTime!)
            let endTime:String = formatter.string(from: slot.endTime!)
            
            
            if firstTime == startTime || firstTime == endTime {
                result.append(createEventDescriptor(slot, slot.title))
            }
        }
        //dayViewControllerImpl.reloadData()
        return result
    }
    
    func newEventColor() -> UIColor {
        return UIColor(SolColor.colors().fontColors.normal)
    }
    
    func createEvent(eventDescriptor: EventDescriptor) -> Void {
        // Создание нового слота
        delegate.addSlot(startTime: eventDescriptor.startDate, endTime: eventDescriptor.endDate)
    }
    
    func updateEvent(eventDescriptor: EventDescriptor) -> Void{
        // запускается когда мы хотим обновить событие в календаре
        if let ev:CalendarKit.Event = eventDescriptor.editedEvent as? CalendarKit.Event {
            if let slotId:String = ev.userInfo as? String {
                //model.changeTimeSlot(id: slotId, newStartDate: eventDescriptor.startDate, newEndDate: eventDescriptor.endDate)
                delegate.changeTimeSlot()
            }
        }
    }
            
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        print((uiViewController as!   DayViewControllerImpl).reloadData != nil)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        dayViewControllerImpl.eventDelegate = self
        dayViewControllerImpl.title = "Schedule task work"
        
        return dayViewControllerImpl
    }
    
    
}
