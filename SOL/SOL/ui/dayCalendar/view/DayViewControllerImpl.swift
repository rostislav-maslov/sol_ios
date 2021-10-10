//
//  CalendarCoordinatorView.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation
import SwiftUI
import EventKit
import CalendarKit

public protocol DayViewControllerProtocol {
    func newEventTitle() -> String
    func eventsForDate(_ date: Date) -> [EventDescriptor]
    func newEventColor() -> UIColor
    func createEvent(eventDescriptor: EventDescriptor) -> Void
    func updateEvent(eventDescriptor: EventDescriptor) -> Void
}

class DayViewControllerImpl: DayViewController {
    var eventDelegate: DayViewControllerProtocol?
    // var generatedEvents = [EventDescriptor]()
    // var alreadyGeneratedSet = Set<Date>()
           
    private var createdEvent: EventDescriptor?
    
    private lazy var rangeFormatter: DateIntervalFormatter = {
        let fmt = DateIntervalFormatter()
        fmt.dateStyle = .none
        fmt.timeStyle = .short
        
        return fmt
    }()
    
    override func loadView() {
        calendar.timeZone = TimeZone.current
        
        dayView = DayView(calendar: calendar)
        view = dayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        navigationController?.navigationBar.isTranslucent = false
        dayView.autoScrollToFirstEvent = true
        reloadData()
    }
    
    // MARK: EventDataSource
    
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return self.eventDelegate!.eventsForDate(date)
    }
           
    // MARK: DayViewDelegate
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        print("Event has been selected: \(descriptor) \(String(describing: descriptor.userInfo))")
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        endEventEditing()
        print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
        beginEditing(event: descriptor, animated: true)
        print(Date())
    }
    
    override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
        endEventEditing()
        print("Did Tap at date: \(date)")
        reloadData()
    }
    
    override func dayViewDidBeginDragging(dayView: DayView) {
        endEventEditing()
        print("DayView did begin dragging")
    }
    
    override func dayView(dayView: DayView, willMoveTo date: Date) {
        print("DayView = \(dayView) will move to: \(date)")
    }
    
    override func dayView(dayView: DayView, didMoveTo date: Date) {
        print("DayView = \(dayView) did move to: \(date)")
    }
    
    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        print("Did long press timeline at date \(date)")
        // Cancel editing current event and start creating a new one
        endEventEditing()
        let event = generateEventNearDate(date)
        print("Creating a new event")
        create(event: event, animated: true)
        createdEvent = event
    }
    
    private func generateEventNearDate(_ date: Date) -> EventDescriptor {
        let duration = 60
        let startDate = Calendar.current.date(byAdding: .minute, value: -Int(CGFloat(duration) / 2), to: date)!
        let event = Event()
        
        event.startDate = startDate
        event.endDate = Calendar.current.date(byAdding: .minute, value: duration - 2, to: startDate)!
        
        var info = ""// TODO data[Int(arc4random_uniform(UInt32(data.count)))]
        
        info.append(rangeFormatter.string(from: event.startDate, to: event.endDate))
        event.text = eventDelegate!.newEventTitle()
        event.color = eventDelegate!.newEventColor()
        
        return event
    }
    
    override func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
        print("did finish editing \(event)")
        print("new startDate: \(event.startDate) new endDate: \(event.endDate)")
        eventDelegate?.updateEvent(eventDescriptor: event)
        event.commitEditing()
                
        if let createdEvent = createdEvent {
            createdEvent.editedEvent = nil
            //generatedEvents.append(createdEvent)
            self.eventDelegate?.createEvent(eventDescriptor: createdEvent)
            self.createdEvent = nil
            endEventEditing()
        }
        
        reloadData()
    }
}
