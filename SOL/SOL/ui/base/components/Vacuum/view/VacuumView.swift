//
//  VacuumView.swift
//  SOL
//
//  Created by Rostislav Maslov on 04.09.2021.
//

import SwiftUI

struct VacuumView: View {
    var body: some View {
        Text("Vacuum")
            .frame(width: .infinity, height: 40, alignment: .center)
            .font(SolFonts.font(size: 32, weight: Font.Weight.heavy, color: SolColor.colors().fontColors.second))
            .foregroundColor(SolColor.colors().fontColors.second)
    }
}

struct VacuumView_Previews: PreviewProvider {
    static var previews: some View {
        VacuumView()
    }
}
