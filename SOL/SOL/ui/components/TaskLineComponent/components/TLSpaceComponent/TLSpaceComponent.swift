//
//  TLSpaceComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import SwiftUI

struct TLSpaceComponent: View {
    var body: some View {
        Text("FTL CallCenter")
            .font(SolFonts.font(size: 12, weight: .medium, color: SolColor.colors().fontColors.second))
            .foregroundColor(SolColor.colors().fontColors.second)
            //.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 320, maxWidth: 320, minHeight: 16, idealHeight: 16, maxHeight: 16, alignment: .leading)
        
    }
}

struct TLSpaceComponent_Previews: PreviewProvider {
    static var previews: some View {
        TLSpaceComponent()
    }
}
