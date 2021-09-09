//
//  EnvModel.swift
//  SOL
//
//  Created by Rostislav Maslov on 08.09.2021.
//

import Foundation

public class EnvModel: ObservableObject {
    @Published var index:Int = 0
    public var store: EnvStore?
    
    func generate(){
        store?.generate()
    }
    
    func inc(){
        store?.inc()
    }
}
