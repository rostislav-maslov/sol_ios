//
//  BackButton.swift
//  SOL
//
//  Created by Rostislav Maslov on 17.07.2021.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
      
    
    var body: some View {
        
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
