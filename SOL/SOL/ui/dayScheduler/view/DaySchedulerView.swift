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
    
    func eventsForDate() -> [String] {
        return []
    }
    
    func newEventColor() -> UIColor {
        return UIColor.red
    }
    
    func newEventCreated(eventDescriptor: EventDescriptor) -> Void {
        // TODO: startDate & endDate
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
