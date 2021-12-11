//
//  ViewResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation


public struct ViewUserResponse: Codable{
    var id: String?
    var canEdit: Bool?
    var createdFromTemplateId: String?
    var hasNewTaskToAdd: Bool?
    var hasTaskAdded: Bool?         
    var ownerId: String?
    var view: ViewResponse?
}
