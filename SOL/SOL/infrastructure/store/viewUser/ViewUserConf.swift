//
//  ViewUserConf.swift
//  SOL
//
//  Created by Rostislav Maslov on 06.02.2022.
//

import Foundation
 

public class ViewUserConf{
    var displayModeChooseSheet: ((_ value: DisplayMode) -> Void)?
    var addedTypeChooseSheet : ((_ value: AddedType) -> Void)?
    var sortChooseSheet : ((_ value: SortType) -> Void)?
    var slotChooseSheet : ((_ value: String) -> Void)?
    var notificationChooseSheet : ((_ value: String) -> Void)?
    var repeatChooseSheet : ((_ value: String) -> Void)?
    var overdueChooseSheet : ((_ value: String) -> Void)?
    var taskIdClosedChooseSheet: ((_ value: String) -> Void)?
    var deadlineDidChangeSheet: ((_ value: String) -> Void)?
    var deadlineExactDateSheet: ((_ value: String) -> Void)?
    var deadlineRelativeChooseSheet: ((_ value: String) -> Void)?
    var spaceChooseSheet: ((_ value: String) -> Void)?
    var chooseParamSheet: ((_ value: String) -> Void)?
    var viewTypeChooseSheet: ((_ value: ViewType) -> Void)?
}
