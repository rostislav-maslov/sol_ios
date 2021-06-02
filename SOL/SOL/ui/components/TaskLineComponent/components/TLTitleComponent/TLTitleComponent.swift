//
//  TLTitleComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import SwiftUI

struct TLTitleComponent: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(SolFonts.font(size: 16, weight: .medium, color: SolColor.colors().fontColors.normal))
            .foregroundColor(SolColor.colors().fontColors.normal)
     
    }
}

struct TLTitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        TLTitleComponent()
    }
}
