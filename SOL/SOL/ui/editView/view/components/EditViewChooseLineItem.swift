//
//  EditViewChooseLineItem.swift
//  SOL
//
//  Created by Rostislav Maslov on 06.02.2022.
//

import Foundation
import SwiftUI

public struct EditViewChooseLineItem: View {
    var title: String
    var value: String
    var action: () -> Void
    
    public var body: some View {
        VStack{
            Button {
                action()
            } label: {
                VStack{
                    HStack{
                        Text(title.description)
                            .foregroundColor(SolColor.colors().fontColors.normal)
                            .font(SolFonts.font(size: 14, weight: Font.Weight.bold, color: SolColor.colors().fontColors.normal))
                        Spacer()
                        Text(value)
                            .foregroundColor(SolColor.colors().fontColors.normal)
                            .font(SolFonts.font(size: 14, weight: Font.Weight.medium, color: SolColor.colors().fontColors.normal))
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())            
        }
        .listRowSeparator(Visibility.hidden)
        .listRowBackground(SolColor.colors().screen.background)
    }
}
