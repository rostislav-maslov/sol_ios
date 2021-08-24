//
//  EditTitleAndIconTaskRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 24.08.2021.
//

import Foundation

public struct EditTitleAndIconTaskRequest: Codable {
    var id: String?
    var title: String?
    var icon:IconResponse?        
}
