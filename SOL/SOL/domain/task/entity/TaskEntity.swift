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
    var deadline:String?
    var description: String = ""
    var externalIds:[String] = []
    var files:[String] = []
    var hasChild:Bool = false
    
    var ownerId:String?
    var parentTaskId:String?
    var pics:[String] = []
    var planningPoints:[String] = []
    var pointWeight:Int = 0
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

extension TaskEntity{
    func fullTitle() -> String {
        var title = title
        if icon.data != "" {
            title = icon.data + " " + title
        }
        return title
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
        var task = TaskEntity()
        task.title = "🪐 hell "
        task.icon.data = "👨‍🎓"
        return task
    }
    public static func forRenderDone() -> TaskEntity {
        var task = TaskEntity()
        task.title = "🪐 hell "
        task.icon.data = "👨‍🎓"
        task.status = TaskStatus.DONE
        return task
    }
}
