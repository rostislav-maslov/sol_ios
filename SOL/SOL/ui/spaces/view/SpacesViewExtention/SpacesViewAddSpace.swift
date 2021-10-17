//
//  SpacesViewAddSpace.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.09.2021.
//

import Foundation
import SwiftUI


extension SpacesView {
    func needCloseSheet(){
        model.onDissmisAddSpace()        
    }
    
    var addSpaceSheet: some View {
        Text("")
            .sheet(isPresented: $model.showAddSpaceSheet, onDismiss:{
                model.onDissmisAddSpace()
            }) {
                AddSpaceView {
                    needCloseSheet()
                }
            }
            .background(SolColor.colors().screen.background)
            .preferredColorScheme(.light)
    }
}
