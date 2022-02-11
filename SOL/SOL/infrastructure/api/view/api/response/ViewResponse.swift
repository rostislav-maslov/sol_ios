//
//  ViewResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation

public struct ParamResponse: Codable{
    var id: String?
    var type: ParamsType?
    var valueBool: Bool?
    var valueDate: Date?
    var valueString: String?
}

public struct IconReponse: Codable{
    var data: String?
    var type: String?
}

public enum ViewType: String, Codable{
    case CUSTOM = "CUSTOM"
    case PARAMS = "PARAMS"
    
    var description: String {
        switch self {
        case . CUSTOM: return "Custom"
        case .PARAMS: return "Params"
        }
    }
}

public enum SortType: String, Codable {
    case BY_CREATE = "BY_CREATE"
    case BY_DEADLINE = "BY_DEADLINE"
    case CUSTOM = "CUSTOM"
    case BY_TITLE = "BY_TITLE"
    
    var description: String {
        switch self {
        case .BY_CREATE:
            return "By create"
        case .BY_DEADLINE:
            return "By deadline"
        case .CUSTOM:
            return "Custom"
        case .BY_TITLE:
            return "By title"
        }
    }
}

public enum DisplayMode: String, Codable {
    case LIST = "LIST"
    case TIMELINE = "TIMELINE"
    case CONCENTRATE = "CONCENTRATE"
    
    var description: String {
        switch self {
        case .LIST:
            return "List"
        case .TIMELINE:
            return "Timeline"
        case .CONCENTRATE:
            return "Concentrate"
        }
    }
}

public enum AddedType: String, Codable {
    case MANUALLY = "MANUALLY"
    case AUTO = "AUTO"
    
    var description: String {
        switch self {
        case .MANUALLY:
            return "Manually"
        case .AUTO:
            return "Auto"
        }
    }
}

public enum ParamsType: String, Codable {
    case SLOT_TIME = "SLOT_TIME"
    case NOTIFICATION = "NOTIFICATION"
    case DEADLINE_EXACT_DATE = "DEADLINE_EXACT_DATE"
    case HAS_REPEAT = "HAS_REPEAT"
    case DEADLINE_RELATIVE_DATE = "DEADLINE_RELATIVE_DATE"
    case TASK_IS_OVERDUE = "TASK_IS_OVERDUE"
    case CLOSED = "CLOSED"
    case FROM_SPACE = "FROM_SPACE"
    case DEADLINE_CHANGED_FEW_TIMES = "DEADLINE_CHANGED_FEW_TIMES"
    
    var description: String {
        switch self {
        case .SLOT_TIME:
            return "Has slot"
        case .NOTIFICATION:
            return "Has notification"
        case .DEADLINE_EXACT_DATE:
            return "Filter by deadline exact date"
        case .HAS_REPEAT:
            return "Has repeat"
        case .DEADLINE_RELATIVE_DATE:
            return "Filter by deadline relative date"
        case .TASK_IS_OVERDUE:
            return "Task is overdue"
        case .CLOSED:
            return "Task closed"
        case .FROM_SPACE:
            return "Task from space"
        case .DEADLINE_CHANGED_FEW_TIMES:
            return "Deadline changed few times"
        }
    }
}

public struct ViewResponse: Codable{
    var viewType: ViewType?
    var addedType: AddedType?
    var description: String?
    var displayMode: DisplayMode?
    var icon: IconReponse?
    var params: [ParamResponse]
    var sortType: SortType?
    var title: String?
}
