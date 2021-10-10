//
//  SlotsDraftModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.10.2021.
//

import Foundation
import Combine

public class SlotsDraftModel: NSObject, ObservableObject {
    @Published var slotsDraft: [SlotEntity] = []
    
    private var disposables = Set<AnyCancellable>()
    private let port:SlotRepositoryPort = SolApiService.api().slot
    
    
}


