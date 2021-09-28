//
//  AddTaskModalViewModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation
import Combine
import SwiftUI

public class AddTaskViewModel: ObservableObject, MultilineTextFieldProtocol {
    var spaceId: String?
    var parentTaskId: String?
    var taskStore: TaskStore?
    var spaceStore: SpaceStore?
    
    var taskDidCreated: (() -> Void)
    
    @Published var state: AddTaskState = AddTaskState.PLACEHOLDER
    @Published var task: TaskEntity = TaskEntity()
    @Published var sheets: SheetsState = SheetsState()
    @Published var buttonState: ButtonState = ButtonState()
    @Published var loadingStatus: ViewState = ViewState.NORMAL
    @Published var titleTextSize: CGFloat = 45.0
    
    @Published var taskInfoText: String = ""
    @Published var taskInfoSize: CGFloat = 0.0
    @Published var hasTaskInfo: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task as TaskRepositoryPort
    
    init(_ spaceId: String?, parentTaskId: String?, taskDidCreated: @escaping (() -> Void)){
        self.spaceId = spaceId
        self.parentTaskId = parentTaskId
        self.taskDidCreated = taskDidCreated
    }
    
    public func removeTimeSlot(startDate: Date) {
        task.slots.removeAll { (check: SlotEntity) in
            return check.startDate == startDate
        }
    }
    
    public func addTimeSlot(startDate: Date, endDate: Date) {
        let slot:SlotEntity = SlotEntity()
        slot.startDate = startDate
        slot.endDate = endDate
        
        task.slots.append(slot)
    }
    
    
    public func changeTimeSlot(id: String, newStartDate: Date, newEndDate: Date){
        for slot in task.slots {
            if slot.id == id {
                slot.endDate = newEndDate
                slot.startDate = newStartDate
            }
        }
    }
    
    private func goToState(_ newState: AddTaskState) {
        if newState == .TEXT && state != newState {
            sheets.deadline = false
            sheets.planning = false
            state = .TEXT
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
        refillTaskInfoText()
        goToState(.TEXT)
        
        self.buttonState.hasSlots = self.task.slots.count > 0
        self.buttonState.hasNotification = false
        self.buttonState.hasDeadline = self.task.deadline != nil
        self.buttonState.hasRepeat = false
        self.buttonState.submitButtonActive = self.task.title.count > 0
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

extension AddTaskViewModel {
    public class ButtonState {
        var hasSlots: Bool = false
        var hasNotification: Bool = false
        var hasDeadline: Bool = false
        var hasRepeat: Bool = false
        var submitButtonActive: Bool = false
    }
}

extension AddTaskViewModel {
    public func clean(){
        task = TaskEntity()
        sheets = SheetsState()
        buttonState = ButtonState()
        touchBackground()
        taskInfoText = ""
        hasTaskInfo = false
    }
    
    public func createTask(){
        
        self.loadingStatus = .NORMAL
        self.state = AddTaskState.PLACEHOLDER
        taskStore?.create( title: task.title,
                           emoji: task.icon.data,
                           parentTaskId: parentTaskId,
                           spaceId: spaceId,
                           deadline: task.deadline,
                           deadlineType: task.deadlineType,
                           timezone: Date().timezone)
        
        self.loadingStatus = .NORMAL
        self.state = AddTaskState.PLACEHOLDER
        self.task = TaskEntity()
        self.taskDidCreated()                
    }
}

extension AddTaskViewModel{
    func submit(){
        if task.title == "" {
            return 
        }
        createTask()
        clean()
    }
}

// M
extension AddTaskViewModel {
    public func textDidChange(text: String){
        self.task.title = text        
    }
    public func textEditFinish(text: String){
        self.submit()
    }
    public func titleSizeDidChange(titleSize: CGFloat){
        if self.titleTextSize != titleSize {
            self.titleTextSize = titleSize
        }
    }
    public func multilineTextFieldView(view: UITextView){
        view.becomeFirstResponder()
    }
}

// MARK: Work with task info line
extension AddTaskViewModel {
    
    func refillTaskInfoText(){
        self.taskInfoText = task.taskInfo
        self.hasTaskInfo = task.hasTaskInfo
        if hasTaskInfo == true {
            withAnimation {           
                self.taskInfoSize = 13.5
            }            
        }else{
            self.taskInfoSize = 0.0
        }
    }
}

extension AddTaskViewModel {
    
}
