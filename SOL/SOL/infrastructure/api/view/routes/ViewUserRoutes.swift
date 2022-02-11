//
//  ViewRoutes.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation

class ViewUserRoutes {
    static let ROOT = BaseRoutes.V1 + "/view-user"
    static let ADD_TASK = ROOT + "/add-task"
    static let MY_ROOT = ROOT + "/root"
    static let ALL = ROOT + "/all"
    static let BY_TASK = ROOT + "/by-task"
    static let BY_VIEW = ROOT + "/by-view"
}
