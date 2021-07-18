//
//  SettingButton.swift
//  SOL
//
//  Created by Rostislav Maslov on 17.07.2021.
//

import SwiftUI

struct SettingButton: View {
    var body: some View {
                Button(action: {                    
                    
                }) {
                    HStack {
                        Image("ic_edit_20")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(
                                SolColor.colors().addTask.taskButtonActiveColor
                            )
                            .scaledToFit()
                    }
                }
    }
}

struct SettingButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingButton()
    }
}
