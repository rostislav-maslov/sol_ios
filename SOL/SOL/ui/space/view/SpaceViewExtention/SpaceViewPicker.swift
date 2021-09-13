//
//  SpaceViewPicker.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.08.2021.
//

import Foundation
import SwiftUI
import NavigationStack

extension SpaceView {
    var picker: some View {
        HStack{
            Spacer().frame(width: 12, height: 1, alignment: .center)
            Picker(selection: $model.activeTab, label: Text("")) {
                Text("Tasks").tag(0)
                Text("Details").tag(1)
            }
            .id("SpaceView_ Picker" + spaceStore.spaces[spaceId]!.lastUpdateUUID.uuidString)
            .pickerStyle(SegmentedPickerStyle())
            Spacer().frame(width: 12, height: 1, alignment: .center)
        }
    }
    
    var pickerContainer: some View {
        VStack{
            if(model.activeTab == 0){
                subtasks
            }
            if(model.activeTab == 1){
                Text("Details")
            }
            Spacer().frame(height: 142)
        }
    }
}
