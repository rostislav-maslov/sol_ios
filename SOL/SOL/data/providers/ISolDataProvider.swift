//
//  SolDataProvider.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.05.2021.
//

import Foundation

class ISolDataProvider {
    var updated:FuncUpdated
    
    init(updated: @escaping FuncUpdated) {
        self.updated = updated
    }
}
