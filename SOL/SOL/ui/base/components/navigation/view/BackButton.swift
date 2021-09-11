//
//  BackButton.swift
//  SOL
//
//  Created by Rostislav Maslov on 17.07.2021.
//

import SwiftUI
import NavigationStack

struct BackButton: View {
    @EnvironmentObject private var navigationStack: NavigationStack   
    
    var body: some View {
        
                Button(action: {
                    self.navigationStack.pop()
//                    self.presentation.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image("ic_arrow-back")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 32, height: 32, alignment: .center)
                            .foregroundColor(
                                SolColor.colors().addTask.taskButtonActiveColor
                            )
                            .scaledToFit()
                    }
                }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
