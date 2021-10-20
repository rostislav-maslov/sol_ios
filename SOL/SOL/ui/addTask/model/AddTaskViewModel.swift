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
    
    var taskStore: TaskStore?
    var spaceStore: SpaceStore?    
    
    var taskDidCreated: (() -> Void)?
    
    @Published var spaceId: String?
    @Published var parentTaskId: String?
    
    @Published var state: AddTaskState = AddTaskState.PLACEHOLDER
    @Published var task: TaskEntity = TaskEntity()
    //@Published var sheets: SheetsState = SheetsState()
    @Published var showDeadline:Bool = false
    @Published var buttonState: ButtonState = ButtonState()
    @Published var loadingStatus: ViewState = ViewState.NORMAL
    @Published var titleTextSize: CGFloat = 45.0
        
    @Published var taskInfoSize: CGFloat = 0.0
    @Published var titleTextView: UITextView?
    @Published var showToastSuccessCreate = false
    @Published var needShowTaskCreatedToast = false
    @Published var planningSlotsModel: PlanningSlotsModel = PlanningSlotsModel()
    
    private var disposables = Set<AnyCancellable>()
    private let port:TaskRepositoryPort = SolApiService.api().task as TaskRepositoryPort        
    
    public func changeView(spaceId: String?, taskId: String?, taskDidCreated: @escaping (() -> Void)){
        self.spaceId = spaceId
        self.parentTaskId = taskId
        self.taskDidCreated = taskDidCreated
        
        planningSlotsModel.title = "When you want to work on a task?"
        
        clean()
        touchBackground()
    }
    
    public func removeTimeSlot(startTime: Date) {
        task.slots.removeAll { (check: SlotEntity) in
            return check.startTime == startTime
        }
    }
    
    public func addTimeSlot(startTime: Date, endTime: Date) {
        let slot:SlotEntity = SlotEntity()
        slot.startTime = startTime
        slot.endTime = endTime
        
        task.slots.append(slot)
    }
    
    private func goToState(_ newState: AddTaskState) {
        if newState == .TEXT && state != newState {
            showDeadline = false
            planningSlotsModel.isPresented = false
            state = .TEXT
            return
        }
        
        if newState == .PLANNING && state != newState {
            showDeadline = false
            planningSlotsModel.newSlotTitle = task.fullTitle
            planningSlotsModel.allSlots = []
            planningSlotsModel.drafts = task.slots
            planningSlotsModel.isPresented = true
            state = newState
            DispatchQueue.main.async {
                self.planningSlotsModel.dayViewControllerImpl.reloadData()
            }
                                   
        }
        
        if newState == .DEADLINE  && state != newState {
            //state = newState
            showDeadline = true
            //sheets.planning = false
        }
        
    }
    
    func touchBackground() {
        loadingStatus = .NORMAL        
        
        planningSlotsModel.isPresented = false
        showDeadline = false
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
        planningSlotsModel.isPresented = false
        showDeadline = false
    }
    
    
}



extension AddTaskViewModel{
    func goToText() {
        task.reculcSlotsTime()
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
        @Published var planning:Bool = false
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

// MARK: Send task to backend
extension AddTaskViewModel {
    public func clean(){
        task = TaskEntity()
        //sheets = SheetsState()
        buttonState = ButtonState()        
        //touchBackground()
    }
    
    public func createTask(){
        taskStore?.create( title: task.title,
                           emoji: task.icon.data,
                           parentTaskId: parentTaskId,
                           spaceId: spaceId,
                           deadline: task.deadline,
                           deadlineType: task.deadlineType,
                           timezone: Date().timezone,
                           slots: task.slots
        )
        taskDidCreated?()
    }
  
    func submit(_ needClose: Bool){
        if task.title == "" {
            return
        }
        
        UINotificationFeedbackGenerator.generate(.TASK_CREATE)
        
        createTask()
        clean()
        
        if needShowTaskCreatedToast == true {
            showToastSuccessCreate = true
        }        
        
        if needClose == true {
            touchBackground()
        }else {
            
            DispatchQueue.main.async {
                self.titleTextView?.text = ""
                self.titleTextView?.becomeFirstResponder()
            }
        }
    }
}

// MARK:  Title text field
extension AddTaskViewModel {
    public func textDidChange(text: String){
        self.task.title = text        
    }
    public func textEditFinish(text: String){
        self.submit(false)
    }
    public func titleSizeDidChange(titleSize: CGFloat){
        if self.titleTextSize != titleSize {
            self.titleTextSize = titleSize
        }
    }
    public func multilineTextFieldView(view: UITextView){
        titleTextView = view
        view.becomeFirstResponder()
    }
}

// MARK: Work with task info line
extension AddTaskViewModel {
    
    func refillTaskInfoText(){
        if task.hasTaskInfo == true {
            withAnimation {           
                self.taskInfoSize = 13.5
            }            
        }else{
            self.taskInfoSize = 0.0
        }
    }
}


//MARK: DaySchedulerProtocol
//TODO: 
extension AddTaskViewModel {
    func newSlotName() -> String {
        return task.fullTitle
    }
    
    func addSlot(startTime: Date, endTime: Date) {
        let slot: SlotEntity = SlotEntity()
        slot.id = UUID().uuidString
        slot.title = task.title
        slot.startTime = startTime
        slot.endTime = endTime
        slot.spaceId = self.spaceId
        slot.slotsMilliseconds = endTime.millisecondsSince1970 - startTime.millisecondsSince1970
        slot.isDraft = true
        slot.timezone = Date().timezone
        task.slots.append(slot)
    }
    
    func drafts() -> [SlotEntity] {
        return task.slots
    }
    
    func onClose() {
        task.reculcSlotsTime()
        goToText()
    }
    
    func onSubmit() {
        task.reculcSlotsTime()
        goToText()
    }
    
    func onTapEvent(slot: SlotEntity) {
        // NOTE ignore
    }
    
    public func changeTimeSlot(slotId id: String, startTime newStartTime: Date, endTime newEndTime: Date) {
        for slot in task.slots {
            if slot.id == id {
                slot.endTime = newEndTime
                slot.startTime = newStartTime
            }
        }
    }
    
    func onDeleteDraft(slotId: String) {
        for i in 0...task.slots.count {
            task.slots.remove(at: i)
            break
        }        
    }
    
}
