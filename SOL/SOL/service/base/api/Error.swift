//
//  Error.swift
//  SOL
//
//  Created by Rostislav Maslov on 29.05.2021.
//

import Foundation

struct PresentationData: Codable {
    var title:String = ""
    var message:String = ""
}

struct Error: Codable {
    var presentationData:PresentationData = PresentationData()
    var domain:String = ""
    var detail:String = ""
}
