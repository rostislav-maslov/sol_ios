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



struct DaySchedulerView: UIViewControllerRepresentable {
    @ObservedObject var model: PlanningSlotsModel
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        model.dayViewControllerImpl.eventDelegate = model
        model.dayViewControllerImpl.title = "Schedule task work"
        
//        if needUpdate == true {
//            needUpdate = false
//            allSots = []
//            DispatchQueue.main.async {
//                dayViewControllerImpl.reloadData()
//            }
//        }
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        model.dayViewControllerImpl.eventDelegate = model
        model.dayViewControllerImpl.title = "Schedule task work"
        
        return model.dayViewControllerImpl
    }
    
    
}
