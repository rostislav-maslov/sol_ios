//
//  HeaderComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 30.05.2021.
//

import SwiftUI

struct HeaderComponent: View {
    var value: String
    var onTouch: () -> Void
    
    var body: some View {
        HStack {
            Spacer().frame(width: 16, height: 0, alignment: .center)
            Button(action: self.onTouch, label: {
                Text(self.value)
                    .font(SolFonts.font(size: 24, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.normal))
            }).foregroundColor(SolColor.colors().fontColors.normal)
            Spacer()
        }
        
    }
}

struct HeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        HeaderComponent(value: "Sol.App") {
            
        }
    }
}
