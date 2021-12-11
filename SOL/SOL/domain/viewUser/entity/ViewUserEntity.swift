//
//  ViewUserEntity.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation

public class ViewUserEntity {
    var id: String = UUID().uuidString
    var canEdit: Bool = false
    var createdFromTemplateId: String?
    var hasNewTaskToAdd: Bool = false
    var hasTaskAdded: Bool = false
    var ownerId: String?
    var view: ViewResponse?

}

