//
//  AddTaskToViewButton.swift
//  SOL
//
//  Created by Rostislav Maslov on 11.12.2021.
//

import SwiftUI

struct AddTaskToViewButton: View {
    var title: String
    var isActive: Bool
    var action: () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
        .padding(4)
        .padding(SwiftUI.EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .background(self.isActive ? SwiftUI.Color.black:SwiftUI.Color.white)
        .foregroundColor(self.isActive ? SwiftUI.Color.white: SwiftUI.Color.black)
        .opacity(self.isActive ? 1 : 0.5)
        .cornerRadius(8)
    }
}
