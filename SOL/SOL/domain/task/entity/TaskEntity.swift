//
//  TaskEntity.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation

public class TaskEntity{
    var id: String = ""
    var title: String = ""
    var icon:IconEntity = IconEntity()
    
    var createdFromRepeatTaskId: String?
    var deadline:Date?
    var deadlineType: DeadlineType = DeadlineType.FULL
    var timezone: Int?
    var description: String = ""
    var externalIds:[String] = []
    var files:[String] = []
    var hasChild:Bool = false
    var slotsMilliseconds: Int64 = 0
    
    var ownerId:String?
    var parentTaskId:String?
    var pics:[String] = []        
    var repeatTaskConfId:String?
    var spaceId:String?
    var status:TaskStatus = TaskStatus.OPEN
    var viewIds:[String] = []
    var child:[TaskEntity] = []
    
    var slots: [SlotEntity] = []
    
    var loadStatus: LoadStatus = LoadStatus.INITIAL
    var lastUpdateUUID = UUID()
  
    //View
    var showSubtask: Bool = false
}

// NOTE: Text helpers
extension TaskEntity{
    var fullTitle: String {
        var title = title
        if icon.data != "" {
            title = icon.data + " " + title
        }
        return title
    }
    
    var taskInfo: String {
        var infoText = ""
                
        if slotsPlaceholder != "" {
            infoText =  infoText + slotsPlaceholder
        }
        
        if self.deadline != nil {
            if infoText != "" {
                infoText =  infoText + " · "
            }
            infoText = infoText + self.deadline!.beautify
        }
                
        return infoText
    }
    
    var hasTaskInfo: Bool {
        if self.taskInfo != "" {
            return true
        }
        
        return false
    }
}

extension TaskEntity{
    func isDone() -> Bool {
        
        if status == .DONE {
            return true
        }
        return false
    }
}

extension TaskEntity{
    public static func forRender() -> TaskEntity {
        let task = TaskEntity()
        task.title = "🪐 hell "
        task.icon.data = "👨‍🎓"
        return task
    }
    public static func forRenderDone() -> TaskEntity {
        let task = TaskEntity()
        task.title = "🪐 hell "
        task.icon.data = "👨‍🎓"
        task.status = TaskStatus.DONE
        return task
    }
}

// MARK: - work with slots
extension TaskEntity {
    func reculcSlotsTime(){
        var totalTime: Int64 = 0
        for slot in slots {
            if slot.endTime != nil && slot.startTime?.millisecondsSince1970 != nil{
                totalTime = totalTime + slot.endTime!.millisecondsSince1970 - slot.startTime!.millisecondsSince1970
            }
        }
        slotsMilliseconds = totalTime
    }
    
    var slotsPlaceholder: String {
        let minute: Int64 = 1000 * 60,
            hour: Int64 = minute * 60,
            day: Int64 = hour * 24,
            delta: Int64 = minute * 4
        
        let slotsCalc: Int64 = slotsMilliseconds != Int64(0) ? slotsMilliseconds + delta : slotsMilliseconds
        
        if slotsCalc == 0 {
            return ""
        }else if slotsCalc < (hour){
            return "\(slotsCalc / minute)m"
        }else if slotsCalc < (day){
            return "\(slotsCalc / hour)h"
        }
        return "\(slotsCalc / day)d"
    }
    
    
}
