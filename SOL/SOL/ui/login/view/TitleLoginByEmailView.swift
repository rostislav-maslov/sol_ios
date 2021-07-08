//
//  TitleLoginByEmailComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 27.05.2021.
//

import SwiftUI

struct TitleLoginByEmailComponent: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Mail so mail,")
                .font(SolFonts.font(
                        size: 32,
                        weight: Font.Weight.heavy,
                        color: SolColor.colors().fontColors.normal))
                .multilineTextAlignment(.leading)
            Text("enter it")
                .font(SolFonts.font(
                        size: 32,
                        weight: Font.Weight.heavy,
                        color: SolColor.colors().fontColors.normal))
                .multilineTextAlignment(.leading)
            Text("and password")
                .font(SolFonts.font(
                        size: 32,
                        weight: Font.Weight.heavy,
                        color: SolColor.colors().fontColors.normal))
                .multilineTextAlignment(.leading)

        }
    }
}

struct TitleLoginByEmailComponent_Previews: PreviewProvider {
    static var previews: some View {
        TitleLoginByEmailComponent()
    }
}
