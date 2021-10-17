//
//  TaskPickerView.swift
//  SOL
//
//  Created by Rostislav Maslov on 12.08.2021.
//

import Foundation
import SwiftUI

extension TaskView {
    var picker: some View {
        HStack{
            Spacer().frame(width: 12, height: 1, alignment: .center)
            Picker(selection: $model.activeTab, label: Text("")) {
                Text("Tasks").tag(0)
                Text("Details").tag(1)
                Text("Files").tag(2)
                Text("Photo").tag(3)
            }
            //.id(self.model.listIdHack)
            .pickerStyle(SegmentedPickerStyle())
            
            Spacer().frame(width: 12, height: 1, alignment: .center)
        }
    }
    
    
}
