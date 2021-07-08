//
//  ChooseEventTimeComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.06.2021.
//

import SwiftUI
import CalendarKit
import EventKit
import EventKitUI
import UIKit

struct TestingCalendarController: UIViewControllerRepresentable {
    @Binding var eventDates: [Date]
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(eventDates: $eventDates)
    }
    func makeUIViewController(context: Context) ->  DayViewController {
        var dayView = DayViewController()
        dayView.delegate = context.coordinator
        
        var style = CalendarStyle()
        
        style.timeline.timeIndicator.color = .systemBlue
        style.header.daySelector.todayActiveTextColor = .white
        style.header.daySelector.selectedBackgroundColor = UIColor(.primary)
        style.header.daySelector.todayInactiveTextColor = .systemBlue
        style.header.daySelector.todayActiveBackgroundColor = .systemBlue
        style.header.backgroundColor = UIColor(SolColor.colors().addTask.addTaskBackground)
        //style.header.swipeLabel.font = .systemFont(ofSize: 0.0)
        
        dayView.updateStyle(style)
        var testingEvents:  [Event] =  [Event]()
        var event = Event()
        event.startDate = Date()
        event.endDate = Date()
        event.isAllDay = true
        event.text = "Testing Event"
        dayView.create(event: event)
        
        return dayView
        
    }
    
    
    
    
    func updateUIViewController(_ dayView: DayViewController, context: Context) {
        dayView.delegate = context.coordinator
    }
    
    class Coordinator: NSObject, DayViewDelegate {
        var eventDates: Binding<[Date]>
        
        init(eventDates: Binding<[Date]>) {
            self.eventDates = eventDates
        }
        
        func dayViewDidSelectEventView(_ eventView: EventView) {
            print("dayViewDidSelectEventView")
            print(eventView)
        }
        
        func dayViewDidLongPressEventView(_ eventView: EventView) {
            print("dayViewDidLongPressEventView")
            print(eventView)
        }
        
        func dayView(dayView: DayView, didTapTimelineAt date: Date) {
            print("dayView")
            print(dayView)
            print(date)
            
            var event = Event()
            event.startDate = date
            
            
            let calendar = Calendar.current
            event.endDate  = calendar.date(byAdding: .minute, value: 60, to: event.startDate) ?? Date()
            
            event.text = "Testing Event \(date)"
            dayView.create(event: event)
        }
        
        func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
            print("dayView")
            print(dayView)
            print(date)
        }
        
        func dayViewDidBeginDragging(dayView: DayView) {
            print("dayViewDidBeginDragging")
            print(dayView)
        }
        
        func dayViewDidTransitionCancel(dayView: DayView) {
            print("dayViewDidTransitionCancel")
            print(dayView)
        }
        
        func dayView(dayView: DayView, willMoveTo date: Date) {
            print("Date \(date)")
            print("dayView")
            print(dayView)
        }
        
        func dayView(dayView: DayView, didMoveTo date: Date) {
            print("dayView")
            print(date)
        }
        
        func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
            print("dayView")
            print(event)
        }
        
        
        
    }
}



struct ChooseEventTimeComponent: View {
    @State var eventDates: [Date] = [Date()]
    
    var body: some View {
        VStack{
            Spacer().frame(width: 0, height: 18, alignment: .center)
            Text("Plan your work")
            Spacer().frame(width: 0, height: 12, alignment: .center)
                .background(SolColor.colors().addTask.addTaskBackground)
                .frame(width: .infinity, height: 24, alignment: .center)
            Spacer().frame(width: 0, height: 0, alignment: .center)
            
            TestingCalendarController(eventDates: $eventDates)
            Spacer().frame(width: 0, height: 0, alignment: .center)
        }.background(SolColor.colors().addTask.addTaskBackground)
    }
    
}

struct ChooseEventTimeComponent_Previews: PreviewProvider {
    static var previews: some View {
        ChooseEventTimeComponent()
    }
}
