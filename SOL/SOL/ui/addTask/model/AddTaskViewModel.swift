//
//  AddTaskModalViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation

public class AddTaskViewModel: ObservableObject {
    @Published var state: AddTaskState = AddTaskState.PLACEHOLDER
    @Published var task: TaskEntity = TaskEntity()
    @Published var sheets: SheetsState = SheetsState()
            
    private func goToState(_ newState: AddTaskState) {
        if newState == .TEXT && state != newState {
            state = .TEXT
            sheets.planning = false
            sheets.deadline = false
            return
        }
        
        if newState == .PLANNING && state != newState {
            state = newState
            sheets.deadline = false
            sheets.planning = true
        }
        
        if newState == .DEADLINE  && state != newState {
            state = newState
            sheets.deadline = true
            sheets.planning = false
        }
        
    }
    
    func touchBackground() {
        sheets.planning = false
        sheets.deadline = false
        if state == .TEXT {
            state = .PLACEHOLDER
            return
        }
        if state == .DEADLINE {
            state = .TEXT
            return
        }
        if state == .PLANNING {
            state = .TEXT
            return
        }
        if state == .NOTIFICATION {
            state = .TEXT
            return
        }
        if state == .REPEAT {
            state = .TEXT
            return
        }
        state = .PLACEHOLDER
        sheets.planning = false
        sheets.deadline = false
    }
    
    
}

extension AddTaskViewModel{
    func goToText() {
        goToState(.TEXT)
    }
    
    func goToNotification() {
        goToState(.NOTIFICATION)
    }
    
    func goToPlanning() {
        goToState(.PLANNING)
    }
    
    func goToDeadline() {
        goToState(.DEADLINE)
    }
    
    func goToRepeat() {
        goToState(.REPEAT)
    }
}

extension AddTaskViewModel{
    public class SheetsState{
        var planning:Bool = false
        var deadline:Bool = false
    }
}
