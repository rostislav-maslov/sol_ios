//
//  ViewResponse.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.12.2021.
//

import Foundation

public struct ParamResponse: Codable{
    var id: String?
    var type: String?
    var valueBool: Bool?
    var valueDate: String?
    var valueString: String?
}

public struct IconReponse: Codable{
    var data: String?
    var type: String?
}

public struct ViewResponse: Codable{
    var addedType: String?
    var description: String?
    var displayMode: String?
    var icon: IconReponse?
    var params: [ParamResponse]
    var sortType: String?
    var title: String?
}
