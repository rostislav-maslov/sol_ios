//
//  SolData.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.05.2021.
//

import SwiftUI

typealias FuncUpdated =  () -> Void  

protocol SolDataObservable {
    func dataUpdated() -> Void
    func observableKey() -> String
}

class SolDataProvider {
    var user: UserProvider?
    var space: SpaceProvider?
    fileprivate var liseners: [String: SolDataObservable] = [:]
    
    fileprivate static var instance: SolDataProvider?
    
    init() {
        user = UserProvider()
        space = SpaceProvider()
    }
    
    static func shared() -> SolDataProvider {
        if instance == nil {
            SolDataProvider.instance = SolDataProvider()
        }
        return instance!
    }

    func updated() -> Void {
        for lisn in liseners.values {
                lisn.dataUpdated()
        }
    }
    
    func listen(_ listener: SolDataObservable) -> Void {
        liseners[listener.observableKey()] = listener
    }
    
    func stopListen(_ listener: SolDataObservable) -> Void {
        liseners.removeValue(forKey: listener.observableKey())
    }
    
}
