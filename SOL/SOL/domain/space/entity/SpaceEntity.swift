//
//  SpaceEntity.swift
//  SOL
//
//  Created by Rostislav Maslov on 16.07.2021.
//

import Foundation

public class SpaceEntity{
    var id:String = ""
    var title:String = ""
    var icon:IconEntity = IconEntity()
    var sortNum:Int = 1
    
    var tasks:[TaskEntity] = []
}
