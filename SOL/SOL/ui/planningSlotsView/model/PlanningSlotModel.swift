//
//  PlanningSlotModalView.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.10.2021.
//

import Foundation

public class PlanningSlotModel: NSObject, ObservableObject {
    @Published var slot: SlotEntity
    @Published var task: TaskEntity
   
    init(slot: SlotEntity,
         task: TaskEntity){
        self.slot = slot
        self.task = task
    }
}
