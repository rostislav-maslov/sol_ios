//
//  PlanningSlotModalView.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.10.2021.
//

import Foundation

public class SlotModel: NSObject, ObservableObject {
    @Published var title: String = ""
    @Published var slot: SlotEntity?    
    @Published var spaceId: String?
    @Published var taskId: String?
    @Published var canGoToTask: Bool = false
  
    @Published var isPresented: Bool = false
    @Published var buttonState: ViewState = ViewState.NORMAL

}


