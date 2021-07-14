//
//  TaskEntity.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.07.2021.
//

import Foundation

public class TaskEntity{
    var title: String = ""
    var emoji: String = ""
    
    var slots: [SlotEntity] = []
    
    func fullTitle() -> String {
        var title = title
        if emoji != "" {
            title = emoji + " " + title
        }
        return title
    }
    
}
