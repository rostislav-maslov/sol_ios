//
//  TLDeadlineComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import SwiftUI

struct TLDeadlineComponent: View {
    var body: some View {
        Text("12.12.2021")
            .font(SolFonts.font(size: 12, weight: .medium, color: SolColor.colors().fontColors.second))
            .foregroundColor(SolColor.colors().fontColors.second)
        //.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 320, maxWidth: 320, minHeight: 16, idealHeight: 16, maxHeight: 16, alignment: .leading)
    }
}

struct TLDeadlineComponent_Previews: PreviewProvider {
    static var previews: some View {
        TLDeadlineComponent()
    }
}
