//
//  CreateViewUserRequest.swift
//  SOL
//
//  Created by Rostislav Maslov on 06.02.2022.
//

import Foundation

public struct CreateViewUserRequest: Codable{
    var addedType: AddedType
    var description: String
    var displayMode: DisplayMode
    var icon: IconReponse
    var params: [ParamResponse]
    var sortType: SortType
    var title: String
    var viewType: ViewType
}
