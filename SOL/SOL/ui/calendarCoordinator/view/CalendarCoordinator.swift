//
//  CalendarCoordinator.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import SwiftUI
import CalendarKit
import EventKit
import EventKitUI
import UIKit

class DVC: DayViewController {
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        print("dayViewDidSelectEventView")
        print(eventView)
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        print("dayViewDidLongPressEventView")
        print(eventView)
    }
}

struct ChooseEventTimeCoordinator: UIViewControllerRepresentable {
    @Binding var eventDates: [Date]
    
    
    
    func makeUIViewController(context: Context) ->  DayViewController {
        var dayView = DVC()
        dayView.delegate = dayView
        dayView.dataSource = DSCal()
        
        var style = CalendarStyle()
        
        style.timeline.timeIndicator.color = .systemBlue
        style.header.daySelector.todayActiveTextColor = .white
        style.header.daySelector.selectedBackgroundColor = UIColor(.primary)
        style.header.daySelector.todayInactiveTextColor = .systemBlue
        style.header.daySelector.todayActiveBackgroundColor = .systemBlue
        style.header.backgroundColor = UIColor(SolColor.colors().addTask.addTaskBackground)
        //style.header.swipeLabel.font = .systemFont(ofSize: 0.0)
        
        dayView.updateStyle(style)
        
        var event = Event()
        event.startDate = Date()
        
        
        let calendar = Calendar.current
        event.endDate  = calendar.date(byAdding: .minute, value: 60, to: event.startDate) ?? Date()
        
        event.text = "Testing Event"
        event.makeEditable()
        dayView.create(event: event)
        
        return dayView
        
    }
    
    func updateUIViewController(_ dayView: DayViewController, context: Context) {
        //dayView.delegate = context.coordinator
    }
   
  
}
class DSCal: EventDataSource {
    var event = Event()
    var events:[EventDescriptor] = []
    
    init() {
        event.startDate = Date()
        
        
        let calendar = Calendar.current
        event.endDate  = calendar.date(byAdding: .minute, value: 60, to: event.startDate) ?? Date()
        
        event.text = "Testing Event "
        event.commitEditing()
        
        
        events.append(event)
    }
    
    func eventsForDate(_ date: Date) -> [EventDescriptor] {
       
        
return events
    }
}

